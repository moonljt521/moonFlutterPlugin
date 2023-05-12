// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moon_flutter_plugin_example/aa.dart';

import 'package:moon_flutter_plugin_example/main.dart';

void main() {
  // testWidgets('Verify Platform version', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that platform version is retrieved.
  //   expect(
  //     find.byWidgetPredicate(
  //       (Widget widget) => widget is Text &&
  //                          widget.data!.startsWith('Running on:'),
  //     ),
  //     findsOneWidget,
  //   );
  // });

  // testFutureAny();

  testLru();


}

void testLru() {
  var l = LRUCache(5);
  l.put('1', '1');
  l.put('2', '2');
  l.put('3', '3');
  l.put('4', '4');
  l.put('5', '5');

  l.get('1');

  l.put('6', '6');
  l.print1();
}


void testFutureAny()async  {
  var a1 = DateTime.now().millisecondsSinceEpoch;
  print('a1 : $a1');
   var r = await Future.any<dynamic>([
     action(1),
     action(2),
     action(3),
     cancel()
   ]);

}

Future cancel() async {
  return await Future.value(1/0);
}

Future<int> action(int a) async {
  await Future.delayed(Duration(seconds: a));
  return a;
}