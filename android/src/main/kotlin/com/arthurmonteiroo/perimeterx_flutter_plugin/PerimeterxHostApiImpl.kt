package com.arthurmonteiroo.perimeterx_flutter_plugin

import com.arthurmonteiroo.perimeterx_flutter_android.messages.PerimeterxHostApi
import com.perimeterx.mobile_sdk.PerimeterX
import com.perimeterx.mobile_sdk.PerimeterXChallengeResult

class PerimeterxHostApiImpl : PerimeterxHostApi {
 override fun getPerimeterxHeaders(): Map<String, String> = PerimeterX.headersForURLRequest()?.toMap() ?: mapOf()


 override fun handlePerimeterxResponse(
  response: String,
  url: String?,
  callback: (Result<String>) -> Unit
 ) {
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