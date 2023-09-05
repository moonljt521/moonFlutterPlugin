import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:moon_flutter_plugin/moon_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _batter = 'Unknown';
  int rrr = 0;
  final _moonFlutterPlugin = MoonFlutterPlugin();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    // initBatter();
    // initAdd();

    getDeviceInfo();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _moonFlutterPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> initBatter() async {
    String platformVersion;
    try {
      platformVersion =
          await _moonFlutterPlugin.getBatteryLevel() ?? 'Unknown platform batter';
    } on PlatformException {
      platformVersion = 'Failed to get batter.';
    }
    setState(() {
      _batter = platformVersion;
    });
  }

  void getDeviceInfo() async {
    // final deviceInfoPlugin = DeviceInfoPlugin();
    // final deviceInfo = await deviceInfoPlugin.deviceInfo;
    // final allInfo = deviceInfo.data;

    var sn = await _moonFlutterPlugin.getSN();

    print('>>>>>> $sn');
  }

   Future<void> initAdd() async {
    int? r = 0;
    try {

      r=  await _moonFlutterPlugin.add(4);
    } on PlatformException {
        r = 0;
    }
    setState(() {
      rrr = r ?? 0;
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n '
              'Batter is : $_batter \n r: $rrr'),
        ),
      ),
    );
  }
}
