package com.arthurmonteiroo.perimeterx_flutter_plugin

import android.util.Log
import com.arthurmonteiroo.perimeterx_flutter_android.messages.PerimeterXHostApi
import com.perimeterx.mobile_sdk.PerimeterX
import com.perimeterx.mobile_sdk.PerimeterXChallengeResult

class PerimeterXHostApiImpl : PerimeterXHostApi {

 override fun getHeaders(): Map<String, String> {
  return  PerimeterX.headersForURLRequest()?.toMap() ?: mapOf()
 }

 override fun handleResponse(
  response: String,
  url: String,
  callback: (Result<String>) -> Unit
 ) {
  val handled = PerimeterX.handleResponse(response, null) {
    challengeResult: PerimeterXChallengeResult ->
   callback.invoke(Result.success(if(challengeResult == PerimeterXChallengeResult.SOLVED) "solved" else "cancelled"))
   null
  }
  if(!handled){
   callback.invoke(Result.success("failed"))
  }
 }
}