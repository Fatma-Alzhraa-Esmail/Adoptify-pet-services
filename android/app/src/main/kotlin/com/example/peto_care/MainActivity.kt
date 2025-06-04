package com.example.peto_care

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.EventChannel.EventSink
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "petocare.open.my.app/channel"
    private val EVENTS = "petocare.open.my.app/events"
    private var startString: String? = null
    private var linksReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "initialLink") {
                if (startString != null) {
                    result.success(startString)
                }
            }
        }

        EventChannel(flutterEngine.dartExecutor, EVENTS).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(args: Any?, events: EventSink) {
                    linksReceiver = createChangeReceiver(events)
                }

                override fun onCancel(args: Any?) {
                    linksReceiver = null
                }
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val intent = intent
        startString = intent.data?.toString()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.action == Intent.ACTION_VIEW) {
            linksReceiver?.onReceive(applicationContext, intent)
        }
    }

    private fun createChangeReceiver(events: EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context, intent: Intent) {
                val dataString = intent.dataString ?: run {
                    events.error("UNAVAILABLE", "Link unavailable", null)
                    return
                }
                events.success(dataString)
            }
        }
    }
}