import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'moon_flutter_plugin_method_channel.dart';

abstract class MoonFlutterPluginPlatform extends PlatformInterface {
  /// Constructs a MoonFlutterPluginPlatform.
  MoonFlutterPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MoonFlutterPluginPlatform _instance = MethodChannelMoonFlutterPlugin();

  /// The default instance of [MoonFlutterPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMoonFlutterPlugin].
  static MoonFlutterPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MoonFlutterPluginPlatform] when
  /// they register themselves.
  static set instance(MoonFlutterPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> getBatteryLevel() {
    throw UnimplementedError('getBatteryLevel() has not been implemented.');
  }

  Future<int?> add(int a) {
    throw UnimplementedError('add() has not been implemented.');
  }

  Future<Uint8List?> getResource(String resourceName) {
    throw UnimplementedError('add() has not been implemented.');
  }

  Future<String?> getSN() {
    throw UnimplementedError('getSN() has not been implemented.');
  }
}
