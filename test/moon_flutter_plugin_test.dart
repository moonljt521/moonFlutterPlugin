import 'package:flutter_test/flutter_test.dart';
import 'package:moon_flutter_plugin/moon_flutter_plugin.dart';
import 'package:moon_flutter_plugin/moon_flutter_plugin_platform_interface.dart';
import 'package:moon_flutter_plugin/moon_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMoonFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements MoonFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MoonFlutterPluginPlatform initialPlatform = MoonFlutterPluginPlatform.instance;

  test('$MethodChannelMoonFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMoonFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    MoonFlutterPlugin moonFlutterPlugin = MoonFlutterPlugin();
    MockMoonFlutterPluginPlatform fakePlatform = MockMoonFlutterPluginPlatform();
    MoonFlutterPluginPlatform.instance = fakePlatform;

    expect(await moonFlutterPlugin.getPlatformVersion(), '42');
  });
}
