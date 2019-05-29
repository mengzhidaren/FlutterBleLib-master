import 'dart:convert';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_ble_lib_example/yyl/Jdy.dart';

class MtsDevice {
  static final Map<String, MtsDevice> _cache = <String, MtsDevice>{};
  final serviceUUID = JDY.serviceUUID;
  final characteristicUUID = JDY.characteristicUUID;

  //蓝牙反应有点慢 等1秒在操作
  final _oneSecond = Duration(seconds: 1);

  MtsDevice._internal(this._macAddress);

  factory MtsDevice(String macAddress) {
    if (_cache.containsKey(macAddress)) {
      return _cache[macAddress];
    } else {
      final mtsDevice = MtsDevice._internal(macAddress);
      _cache[macAddress] = mtsDevice;
      return mtsDevice;
    }
  }

  String _macAddress;
  var isConnectState = false;
  final control = JDY();
  dynamic refreshUI;
  final mtsData = MtsData();

  void refreshState() {
    if (refreshUI != null) refreshUI();
  }

  void sendStart() {
    _sendBleEvent(control.sendStart(), "sendStart");
  }

  void sendStop() {
    _sendBleEvent(control.sendPause(), "sendStop");
  }

  void setSpeed(int speed) {
    mtsData.speed = speed;
    _sendBleEvent(control.sendMts(mtsData), "setSpeed");
  }

  void setSlow(int flow) {
    mtsData.flow = flow;
    _sendBleEvent(control.sendMts(mtsData), "setSlow");
  }

  void setMode(int mode) {
    mtsData.mode = mode;
    _sendBleEvent(control.sendMts(mtsData), "setMode");
  }

  void _sendBleEvent(dynamic eventArray, String eventID) {
    _runBleEvent(() {
      FlutterBleLib.instance
          .writeCharacteristicForDevice(_macAddress, serviceUUID,
              characteristicUUID, eventArray, true, eventID)
          .then((characteristic) {
        print("$eventID   value=" + characteristic.value);
      }).catchError((_) {});
    });
  }

  void _runBleEvent(dynamic callback) {
    FlutterBleLib.instance.isDeviceConnected(_macAddress).then((isConnected) {
      if (isConnected) {
        callback();
      } else {
        print("isDeviceConnected false");
        isConnectState = false;
        refreshState();
      }
    }).catchError((e) {
      print("error isDeviceConnected");
    });
  }

  void connect() async {
    FlutterBleLib.instance.isDeviceConnected(_macAddress).then((isConnected) {
      if (isConnected) {
        _delayedOneTime(_discoverAllServices);
      } else {
        _delayedOneTime(_connectToDevice);
      }
    }).catchError((e) {
      print("error connect isDeviceConnected");
      _delayedOneTime(_connectToDevice);
    });
  }

  void _resetBLE() {
    FlutterBleLib.instance.destroyClient().catchError((e) {});
    FlutterBleLib.instance.createClient("hot").catchError((e) {});
  }

  ///连接蓝牙
  void _connectToDevice() {
    FlutterBleLib.instance.connectToDevice(_macAddress).then((bleDevice) {
      print("_connectToDevice  isconnect =${bleDevice.isConnected}");
      _delayedOneTime(_discoverAllServices);
//      isConnectState = bleDevice.isConnected;
//      refreshState();
    }).catchError((e) {
      if (e.toString().contains("133")) {
        //133联接异常
        print("error 重置连接 e=" + e.toString());
        _resetBLE();
      } else {
        print("error _connectToDevice e=" + e.toString());
        cancelConnect(false);
      }
    });
  }

  void _delayedOneTime(dynamic callback) async {
    await Future.delayed(_oneSecond);
    callback();
  }

//  void _delayedOneTimeArgs(dynamic callback, dynamic args) async {
//    await Future.delayed(_oneSecond);
//    callback(args);
//  }

  ///已经连接就扫描服务列表UUID
  void _discoverAllServices() {
    FlutterBleLib.instance
        .discoverAllServicesAndCharacteristicsForDevice(_macAddress)
        .then((bleDevice) {
      print("discoverAllServices  isconnect =${bleDevice.isConnected}");
      isConnectState = bleDevice.isConnected;
      refreshState();
      //    _delayedOneTimeArgs(setSpeed, speed); //默认打开1级压力
      _delayedOneTime(_monitorCharacter);
    }).catchError((e) {
      print("error _discoverAllServices");
    });
  }

  void cancelConnect(bool isDestory) {
    FlutterBleLib.instance
        .cancelDeviceConnection(_macAddress)
        .then((bleDevice) {
      print("cancelConnect  result =${bleDevice.isConnected}");
    }).catchError((e) {
      print("cancelConnect  error");
    });
    if (!isDestory) {
      isConnectState = false;
      refreshState();
    }
  }

  ///监听蓝牙连接
  void stateChange() {
    FlutterBleLib.instance.onDeviceConnectionChanged().listen((bleDevice) {
      print("isconnect${bleDevice.isConnected}");
      isConnectState = bleDevice.isConnected;
      refreshState();
    }).onError((_) {
      print("error  onDeviceConnectionChanged");
    });
  }

  ///监听蓝牙手柄通知回调
  void _monitorCharacter() {
    FlutterBleLib.instance
        .monitorCharacteristicForDevice(
            _macAddress, serviceUUID, characteristicUUID, monitorEvent())
        .listen((event) {
      if (event.transactionId == monitorEvent()) {
        _setResponse(event.characteristic.value);
      }
      print(
          "蓝牙手柄通知回调 event=${event.transactionId} value=${event.characteristic.value}");
    }).onError((e) {
      print("error monitorCharacter " + e.toString());
    });
  }

  void debugLog() {
    FlutterBleLib.instance.setLogLevel(LogLevel.VERBOSE);
  }

  void _setResponse(String result) {
    mtsData.setResult(result);
    refreshState();
  }

  ///操作事件ID    订阅事件和取消事件时用到
  monitorEvent() => 'Mts_$_macAddress';

  void clear() {
    FlutterBleLib.instance.cancelTransaction(monitorEvent());
  }
}
