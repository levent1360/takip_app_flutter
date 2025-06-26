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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleSendIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)

        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_SEND == action && "text/plain" == type) {
            handleSendIntent(intent)

            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
                .invokeMethod("onNewSharedText", sharedText)
        }
    }

    private fun handleSendIntent(intent: Intent) {
        val action = intent.action
        val type = intent.type

        if (Intent.ACTION_SEND == action && type == "text/plain") {
            sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
        }
    }
    private fun handleIntent(intent: Intent?) {
    if (intent?.action == Intent.ACTION_SEND && intent.type == "text/plain") {
        val sharedText = intent.getStringExtra(Intent.EXTRA_TEXT)
        if (!sharedText.isNullOrEmpty()) {
            flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                MethodChannel(messenger, CHANNEL).invokeMethod("getSharedText", sharedText)
            }
        }
    }
}

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getSharedText") {
                    result.success(sharedText)
                    sharedText = null // yalnızca bir kere gönder
                }
            }
    }
}