package com.example.callsentinel

import android.telecom.CallScreeningService
import android.telecom.Call
import android.telecom.CallScreeningService.CallResponse

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
