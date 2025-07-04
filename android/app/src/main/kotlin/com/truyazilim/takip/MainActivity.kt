package com.truyazilim.takip

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

public class MainActivity : FlutterActivity() {
    private var sharedText: String? = null
    private val CHANNEL = "app.channel.shared.data"
    private var lastProcessedUrl: String? = null // Son işlenen URL'yi takip etmek için

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent, isFromOnCreate = true)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        handleIntent(intent, isFromOnCreate = false)
    }

    override fun onResume() {
        super.onResume()
        // Arka plandan dönerken yeni bir intent olup olmadığını kontrol et
        if (intent?.action == Intent.ACTION_VIEW || intent?.action == Intent.ACTION_SEND) {
            handleIntent(intent, isFromOnCreate = false)
        }
    }

    private fun handleIntent(intent: Intent?, isFromOnCreate: Boolean) {
        intent ?: return
        
        when {
            intent.action == Intent.ACTION_SEND && intent.type == "text/plain" -> {
                handleSendIntent(intent)
            }
            intent.action == Intent.ACTION_VIEW -> {
                handleViewIntent(intent, isFromOnCreate)
            }
        }
    }

    private fun handleSendIntent(intent: Intent) {
        intent.getStringExtra(Intent.EXTRA_TEXT)?.let { text ->
            if (text != lastProcessedUrl) { // Daha önce işlenmemişse
                lastProcessedUrl = text
                sendToFlutter(text)
            }
        }
    }

    private fun handleViewIntent(intent: Intent, isFromOnCreate: Boolean) {
        val fullUrl = intent.data?.toString()
        Log.d("FULL_URL", "Tam URL: $fullUrl")
        fullUrl?.let { url ->
            // onCreate'ten geliyorsa veya yeni bir URL ise işle
            if (isFromOnCreate || url != lastProcessedUrl) {
                lastProcessedUrl = url
                sendToFlutter(url)
                
                // Eğer uygulama zaten açıksa, intent'i temizle
                if (!isFromOnCreate) {
                    intent.data = null
                    intent.action = ""
                    setIntent(intent)
                }
            }
        }
    }

    private fun sendToFlutter(data: String) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
            MethodChannel(messenger, CHANNEL).invokeMethod("onNewSharedText", data)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getSharedText") {
                    result.success(sharedText)
                    sharedText = null
                }
            }
    }
}