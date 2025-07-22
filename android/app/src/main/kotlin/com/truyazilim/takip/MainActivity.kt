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
    private var lastProcessedUrl: String? = null
    private var isInitialIntentProcessed = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleInitialIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIncomingIntent(intent)
    }

    override fun onResume() {
        super.onResume()
        if (!isInitialIntentProcessed) {
            handleInitialIntent(intent)
        }
    }

    private fun handleInitialIntent(intent: Intent?) {
        intent ?: return
        if (isValidIntent(intent)) {
            handleIncomingIntent(intent)
            isInitialIntentProcessed = true
        }
    }

    private fun handleIncomingIntent(intent: Intent) {
        setIntent(intent) // Güncel intent'i ayarla

        when {
            intent.action == Intent.ACTION_SEND && intent.type == "text/plain" -> {
                handleSendIntent(intent)
            }
            intent.action == Intent.ACTION_VIEW -> {
                handleViewIntent(intent)
            }
        }
    }

    private fun isValidIntent(intent: Intent): Boolean {
        return when {
            intent.action == Intent.ACTION_SEND && intent.type == "text/plain" -> true
            intent.action == Intent.ACTION_VIEW && intent.data != null -> true
            else -> false
        }
    }

    private fun handleSendIntent(intent: Intent) {
        intent.getStringExtra(Intent.EXTRA_TEXT)?.let { text ->

            if (text != lastProcessedUrl) {
                lastProcessedUrl = text
                sharedText = text
                sendToFlutter(text)
            }
        }
    }

    private fun handleViewIntent(intent: Intent) {
        val fullUrl = intent.data?.toString()

        fullUrl?.let { url ->
            if (url != lastProcessedUrl) {
                lastProcessedUrl = url
                sharedText = url
                sendToFlutter(url)
                clearIntentIfNeeded(intent)
            }
        }
    }

    private fun clearIntentIfNeeded(intent: Intent) {
        try {
            intent.data = null
            intent.action = ""
            setIntent(intent)
        } catch (e: Exception) {
        }
    }

    private fun sendToFlutter(data: String) {
        try {
            flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                MethodChannel(messenger, CHANNEL).invokeMethod("onNewSharedText", data)
            }
        } catch (e: Exception) {
        }
    }



    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "getSharedText" -> {
                        result.success(sharedText)
                        sharedText = null
                    }
                    else -> result.notImplemented()
                }
            }
        }
    }
}