package com.arthurmonteiroo.perimeterx_flutter_plugin

import com.arthurmonteiroo.perimeterx_flutter_android.messages.PerimeterXHostApi
import io.flutter.embedding.engine.plugins.FlutterPlugin

/** PerimeterxFlutterPlugin */
class PerimeterxFlutterPlugin: FlutterPlugin {
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    PerimeterXHostApi.setUp(flutterPluginBinding.binaryMessenger, PerimeterXHostApiImpl())
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}
}
