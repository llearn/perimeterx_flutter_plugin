package com.arthurmonteiroo.perimeterx_flutter_plugin

import com.arthurmonteiroo.perimeterx_flutter_android.messages.PerimeterxHostApi
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PerimeterxFlutterPlugin */
class PerimeterxFlutterPlugin: FlutterPlugin {
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    PerimeterxHostApi.setUp(flutterPluginBinding.binaryMessenger, PerimeterxHostApiImpl())
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
