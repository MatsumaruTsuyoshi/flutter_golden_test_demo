import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:flutter_golden_test_demo/main.dart';

void main() {
  testGoldens('app', (WidgetTester tester) async {
    //デバイスの画面サイズ
    final size = Size(415, 896);
    //第一引数はどのWidgetをビルドするのか指定、どのサイズにビルドするかがsurfaceSize
    await tester.pumpWidgetBuilder(MyApp(), surfaceSize: size);
    //正規のスクリーンショットと同じかテストする
    await screenMatchesGolden(tester, 'myApp');
  });
}
