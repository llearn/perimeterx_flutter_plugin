package com.arthurmonteiroo.perimeterx_flutter_plugin

import android.util.Log
import com.arthurmonteiroo.perimeterx_flutter_android.messages.PerimeterXHostApi
import com.perimeterx.mobile_sdk.PerimeterX
import com.perimeterx.mobile_sdk.PerimeterXChallengeResult

class PerimeterXHostApiImpl : PerimeterXHostApi {
 private val TAG = "PerimeterXFlutterPlugin"

 override fun getHeaders(): Map<String, String> = PerimeterX.headersForURLRequest()?.toMap() ?: mapOf()

 override fun handleResponse(
  response: String,
  url: String,
  callback: (Result<String>) -> Unit
 ) {
  Log.d(TAG, "handleResponse: url: $url")
  Log.d(TAG, "handleResponse: response: $response")

  val handled = PerimeterX.handleResponse(response, url) {
    challengeResult: PerimeterXChallengeResult ->
   callback.invoke(Result.success(if(challengeResult == PerimeterXChallengeResult.SOLVED) "solved" else "cancelled"))
   null
  }
  if(!handled){
   callback.invoke(Result.success("failed"))
  }
 }
}