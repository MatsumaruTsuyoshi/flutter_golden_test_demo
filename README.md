# GoldenTestのお試しをしてみた

https://pub.dev/packages/golden_toolkit

このライブラリを使って、検証する

ちなみにマスターのスクリーンショットをGoldenというらしい。

# カウンターアプリでWidgetのカラーが違う場合をテストしてみた

OK想定 | NG想定
:--: | :--:
<img src="https://user-images.githubusercontent.com/73928886/137676130-2e301e77-57bd-4522-bc7e-88252e3d4654.png" width="300" /> | <img src="https://user-images.githubusercontent.com/73928886/137676118-c659d237-26f1-47cb-918f-f92be5d8c0ae.png" width="300" />

# 手順
##  1.  dev_dependenciesに[golden_toolkit](https://pub.dev/packages/golden_toolkit)を追加

##  2.  testフォルダにgolden_test.dartを作成

##  3.  golden_test.dartを編集
```
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
```

##  4.  Golden作成（マスターのスクリーンショット）
以下コマンドでtestフォルダにgoldensファイルが作成され、myApp.pngができているはずです。
```
flutter test --update-goldens
```


Golden(myApp.png) | 
:--: | 
<img src="https://user-images.githubusercontent.com/73928886/137677062-84df4e02-e3a8-4b17-adb9-645644f1da93.png" width="300" /> |

##  5.  実際にテストしてみる（OK編）

OK想定 | 
:--: | 
<img src="https://user-images.githubusercontent.com/73928886/137676130-2e301e77-57bd-4522-bc7e-88252e3d4654.png" width="300" /> |

以下コマンドでテストします。
```
flutter test
```
結果は

```
All tests passed! 
```
のはず。

##  6.  実際にテストしてみる（NG編）
Goldenは変えずに、main.dartのプライマリーカラーを変えてみます。
NG想定 | 
:--: | 
<img src="https://user-images.githubusercontent.com/73928886/137677409-5d9414e4-7bf8-4ad1-9c14-fe56ab7ff493.png" width="300" /> |

以下コマンドでテストします。
```
flutter test
```
結果は

```
Some tests failed. 
```
のはず。

テストに失敗すると、testフォルダにfailuresファイルが作成され、その配下に何が違っていたかのスクショができあがっている.
見ての通り差分をちゃんと判定してくれている、

myApp_masterImage.png | myApp_testImage.png | myApp_maskedDiff.png | myApp_isolatedDiff.png
:--: | :--: | :--: | :--:
<img src="https://user-images.githubusercontent.com/73928886/137678032-b66152a0-f1a8-472c-83ae-4e9bc8af281b.png" width="300" /> | <img src="https://user-images.githubusercontent.com/73928886/137678053-26b71e17-0b55-47b5-8a1a-c8ec11fbaf6f.png" width="300" /> | <img src="https://user-images.githubusercontent.com/73928886/137678069-b36a906b-5396-4a59-a7d6-3685085175c5.png" width="300" /> | <img src="https://user-images.githubusercontent.com/73928886/137678082-b057a210-4874-40d2-8723-9440594eb015.png" width="300" />


