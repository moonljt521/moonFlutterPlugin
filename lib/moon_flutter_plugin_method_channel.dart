import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'moon_flutter_plugin_platform_interface.dart';

/// An implementation of [MoonFlutterPluginPlatform] that uses method channels.
class MethodChannelMoonFlutterPlugin extends MoonFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('moon_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> getBatteryLevel() async {
    final batter = await methodChannel.invokeMethod<String>('getBatteryLevel');
    return batter;
  }

  @override
  Future<int?> add(int a) async {
    final batter = await methodChannel.invokeMethod<int>('add' ,{
      'param1': a,
    });
    return batter;
  }

  @override
  Future<Uint8List?> getResource(String a) async{
    final batter = await methodChannel.invokeMethod<Uint8List>('getResource' ,{
      'resourceName': a,
    });
    return batter;
  }

}
