
import 'dart:typed_data';

import 'moon_flutter_plugin_platform_interface.dart';

class MoonFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return MoonFlutterPluginPlatform.instance.getPlatformVersion();
  }

  Future<String?> getPlatFormSN() {
    return MoonFlutterPluginPlatform.instance.getBatteryLevel();
  }


  Future<String?> getBatteryLevel() {
    return MoonFlutterPluginPlatform.instance.getBatteryLevel();
  }

  Future<int?> add(int a) {
    return MoonFlutterPluginPlatform.instance.add(a);
  }

  Future<Uint8List?> getAssetImage(String target) {
    return MoonFlutterPluginPlatform.instance.getResource(target);
  }
  Future<String?> getSN() {
    return MoonFlutterPluginPlatform.instance.getSN();
  }



}
