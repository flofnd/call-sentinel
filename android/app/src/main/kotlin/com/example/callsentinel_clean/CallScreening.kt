package com.example.callsentinel_clean

import android.telecom.Call
import android.telecom.CallScreeningService
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache

class CallScreening : CallScreeningService() {

    private val CHANNEL = "com.callsentinel/call_info"

    override fun onScreenCall(callDetails: Call.Details) {
        val phoneNumber = callDetails.handle?.schemeSpecificPart ?: "Unknown"
        Log.i("CallScreening", "Incoming call from: $phoneNumber")

        if (phoneNumber.contains("1234") || phoneNumber.contains("spam")) {
            val response = CallResponse.Builder()
                .setDisallowCall(true)
                .setRejectCall(true)
                .setSkipCallLog(false)
                .setSkipNotification(false)
                .build()
            respondToCall(callDetails, response)
            Log.i("CallScreening", "Call blocked: $phoneNumber")
        } else {
            val response = CallResponse.Builder()
                .setDisallowCall(false)
                .setRejectCall(false)
                .setSkipCallLog(false)
                .setSkipNotification(false)
                .build()
            respondToCall(callDetails, response)

            Log.i("CallScreening", "Call allowed: $phoneNumber")

            // 🚀 Send phone number to Flutter via MethodChannel
            try {
                val engine = FlutterEngineCache.getInstance().get("main_engine")
                if (engine != null) {
                    val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
                    channel.invokeMethod("incoming_call", phoneNumber)
                    Log.i("CallScreening", "Sent phone number to Flutter.")
                } else {
                    Log.e("CallScreening", "Flutter engine is null.")
                }
            } catch (e: Exception) {
                Log.e("CallScreening", "Error sending to Flutter: $e")
            }
        }
    }
}
