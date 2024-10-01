package com.arthurmonteiroo.perimeterx_flutter_plugin_example

import android.app.Application
import com.perimeterx.mobile_sdk.PerimeterX
import com.perimeterx.mobile_sdk.main.PXPolicy
import com.perimeterx.mobile_sdk.main.PXPolicyUrlRequestInterceptionType
import com.perimeterx.mobile_sdk.main.PXStorageMethod

class MainApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        try {
            val policy = PXPolicy()
            policy.storageMethod = PXStorageMethod.DATA_STORE
            policy.urlRequestInterceptionType = PXPolicyUrlRequestInterceptionType.NONE
            policy.doctorCheckEnabled = true
            PerimeterX.start(this, "PXj9y4Q8Em", null, policy)
        }
        catch (exception: Exception) {
            println("failed to start. exception: $exception")
        }
    }
}