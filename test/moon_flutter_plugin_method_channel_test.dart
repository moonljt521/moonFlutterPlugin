import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_flutter_plugin/moon_flutter_plugin_method_channel.dart';

void main() {
  MethodChannelMoonFlutterPlugin platform = MethodChannelMoonFlutterPlugin();
  const MethodChannel channel = MethodChannel('moon_flutter_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
