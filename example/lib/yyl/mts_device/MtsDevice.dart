import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_ble_lib_example/yyl/Jdy.dart';

class MtsDevice {
  static final Map<String, MtsDevice> _cache = <String, MtsDevice>{};
  final serviceUUID = JDY.serviceUUID;
  final characteristicUUID = JDY.characteristicUUID;

  factory MtsDevice(String macAddress) {
    if (_cache.containsKey(macAddress)) {
      return _cache[macAddress];
    } else {
      final mtsDevice = MtsDevice._internal(macAddress);
      _cache[macAddress] = mtsDevice;
      return mtsDevice;
    }
  }

  MtsDevice._internal(this._macAddress);

  String _macAddress;
  bool isConnectState = false;

  //蓝牙反应有点慢 等1秒在操作
  final _oneSecond = Duration(seconds: 1);
  final control = JDY();
  dynamic refreshUI;

  var flow = 1;
  var speed = 1;
  var mode = 1;

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
    this.speed = speed;
    _sendBleEvent(control.sendMts(speed, flow, mode), "sendMts");
  }

  void setSlow(int flow) {
    this.flow = flow;
    _sendBleEvent(control.sendMts(speed, flow, mode), "sendMts");
  }

  void setMode(int mode) {
    this.mode = mode;
    _sendBleEvent(control.sendMts(speed, flow, mode), "sendMts");
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

  void stateChange() {
    FlutterBleLib.instance.onDeviceConnectionChanged().listen((bleDevice) {
      print("isconnect${bleDevice.isConnected}");
      isConnectState = bleDevice.isConnected;
      refreshState();
    }).onError((_) {
      print("error  onDeviceConnectionChanged");
    });
  }

  void _monitorCharacter2(int characteristicIdentifier) {}

  void _monitorCharacter() {
    FlutterBleLib.instance
        .monitorCharacteristicForDevice(
            _macAddress, serviceUUID, characteristicUUID, monitorEvent)
        .listen((event) {
      print(
          "event=${event.transactionId}  \n value=${event.characteristic.value}");
    }).onError((e) {
      print("error monitorCharacter " + e.toString());
    });
  }

  final monitorEvent = "characterEvent";

  void clear() {
    //  FlutterBleLib.instance.cancelTransaction(monitorEvent);
  }
}
