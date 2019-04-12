import 'package:flutter/material.dart';
import 'package:flutter_ble_lib_example/ui/main_devices_list.dart';
import 'package:flutter_ble_lib_example/ui/splash.dart';
import 'package:flutter_ble_lib_example/ui/screen_names.dart' as ScreenNames;

const Color polideaColor = const Color.fromRGBO(25, 159, 217, 1.0);
void main() {
  runApp(new MaterialApp(
//    home: new OnBoardingPager(),
    home: new BleDevicesScreen(),
    theme: new ThemeData(
      canvasColor: polideaColor,
      iconTheme: new IconThemeData(color: Colors.white),
      accentColor: Colors.pinkAccent,
      brightness: Brightness.dark,
    ),
//    routes: <String, WidgetBuilder>{
//      ScreenNames.bleDevicesScreen: (
//          BuildContext context) => new BleDevicesScreen(),
//    },
  ));
}
