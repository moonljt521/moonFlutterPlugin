package com.example.moon_flutter_plugin

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.ByteArrayOutputStream

/** MoonFlutterPlugin */
class MoonFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  lateinit var applicationContext: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "moon_flutter_plugin")

    applicationContext = flutterPluginBinding.applicationContext

    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "getBatteryLevel") {

      result.success("${getPhoneBattery(applicationContext)}%")
    } else if(call.method == "add"){
       val argument = call.arguments as? Map<String,Any>
       val a1 = argument?.get("param1") as? Int
       val r = (a1 ?:0) + 5
       result.success(r)
    } else if(call.method == "getResource"){
      val argument = call.arguments as? Map<String,Any>
      val a1 = argument?.get("resourceName") as? String
      if(a1 == null) return
      val by = getImageAsBytes(a1)
      result.success(by)
    } else if (call.method == "getSN") {

      val sn = SystemProperties.getSN()
      result.success(sn)


    }

    else{
      result.notImplemented()
    }
  }

  private fun getPhoneBattery(context: Context): Int {
    var level = 0
    var batterySum = 100
    val batteryInfoIntent: Intent? = context.applicationContext.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    if (batteryInfoIntent != null) {
      level = batteryInfoIntent.getIntExtra("level", 0)
      batterySum = batteryInfoIntent.getIntExtra("scale", 100)
    }
    return 100 * level / batterySum
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getImageAsBytes(imageName: String): ByteArray? {
    val imageId = applicationContext.resources.getIdentifier(imageName, "drawable", applicationContext.packageName)
    if (imageId == 0) {
      return null
    }
    val imageBitmap = BitmapFactory.decodeResource(applicationContext.resources, imageId)
    val  bos = ByteArrayOutputStream()
    imageBitmap.compress(Bitmap.CompressFormat.PNG,100,bos)
    return bos.toByteArray()
  }

}
