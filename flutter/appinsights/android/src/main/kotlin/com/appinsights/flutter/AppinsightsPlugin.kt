package com.appinsights.flutter

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.content.Context;
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import com.appinsights.PanelSDK
import com.appinsights.*
import kotlinx.coroutines.*

/** AppinsightsPlugin */
class AppinsightsPlugin: FlutterPlugin, MethodCallHandler {
  private val mainScope = CoroutineScope(Dispatchers.Main + SupervisorJob())
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var appContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "appinsights")
    channel.setMethodCallHandler(this)
    appContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "initialize") {
      val partnerId = call.argument<String>("partnerId") ?: ""
      val partnerKey = call.argument<String>("partnerKey") ?: ""

      PanelSDK.init(
        this.appContext,
        partnerId = partnerId,
        partnerKey = partnerKey)
      result.success(null)
    } else if (call.method == "sendData") {
      mainScope.launch {
        PanelSDK.sendData(appContext)
      }
      return result.success(null)
    } else if (call.method == "setUserId") {
      val userId = call.argument<String>("userId") ?: ""
      if (!userId.isEmpty()) {
        PanelSDK.setUserId(userId)
      }
      return result.success(userId)
    } else if (call.method == "recordPermissionUpdate") {
      PanelSDK.recordPermissionUpdate(this.appContext)
      return result.success("")
    } else if (call.method == "getState") {
      return result.success(PanelSDK.getState(this.appContext).toString())
    } else if (call.method == "openUsageAccessSettings") {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS).apply {
          data = Uri.fromParts("package", appContext.packageName, null)
          flags = Intent.FLAG_ACTIVITY_NEW_TASK
        }
        this.appContext.startActivity(intent)
        result.success(null)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
