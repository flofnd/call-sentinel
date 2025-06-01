package com.example.callsentinel_clean

import android.telecom.CallScreeningService
import android.telecom.Call

class CallScreening : CallScreeningService() {
    override fun onScreenCall(callDetails: Call.Details) {
        val response = CallResponse.Builder()
            .setDisallowCall(false)
            .setRejectCall(false)
            .setSkipCallLog(false)
            .setSkipNotification(false)
            .build()

        respondToCall(callDetails, response)
    }
}
