import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_ble_lib_example/yyl/Jdy.dart';

class SuctionDevice {
  static final Map<String, SuctionDevice> _cache = <String, SuctionDevice>{};
  final serviceUUID = JDY.serviceUUID;
  final characteristicUUID = JDY.characteristicUUID;

  factory SuctionDevice(String macAddress) {
    if (_cache.containsKey(macAddress)) {
      return _cache[macAddress];
    } else {
      final hotDevice = SuctionDevice._internal(macAddress);
      _cache[macAddress] = hotDevice;
      return hotDevice;
    }
  }

  SuctionDevice._internal(this._macAddress);

  String _macAddress;
  bool isConnectState = false;

  //蓝牙反应有点慢 等1秒在操作
  final _oneSecond = Duration(seconds: 1);
  final hogControl = JDY();

  dynamic refreshUI;

  void refreshState() {
    if (refreshUI != null) refreshUI();
  }

  void sendStart() {
    _sendBleEvent(hogControl.sendStart(), "sendStart");
  }

  void sendStop() {
    _sendBleEvent(hogControl.sendPause(), "sendStop");
  }

  void sendP(int value) {
    print("sendP $value");
    _sendBleEvent(hogControl.setHogPressure(value), "setHogPressure");
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

  void connect() {
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
        cancelConnect();
      }
    });
  }

  void _delayedOneTime(dynamic callback) async {
    await Future.delayed(_oneSecond);
    callback();
  }

  void _delayedOneTimeArgs(dynamic callback, dynamic args) async {
    await Future.delayed(_oneSecond);
    callback(args);
  }

  ///已经连接就扫描服务列表UUID
  void _discoverAllServices() {
    FlutterBleLib.instance
        .discoverAllServicesAndCharacteristicsForDevice(_macAddress)
        .then((bleDevice) {
      print("discoverAllServices  isconnect =${bleDevice.isConnected}");
      isConnectState = bleDevice.isConnected;
      refreshState();
      _delayedOneTimeArgs(sendP, 1); //默认打开1级压力 不然开机没反应
    }).catchError((e) {
      print("error _discoverAllServices");
    });
  }

  void cancelConnect() {
    FlutterBleLib.instance
        .cancelDeviceConnection(_macAddress)
        .then((bleDevice) {
      print("cancelConnect  result =${bleDevice.isConnected}");
    }).catchError((e) {
      print("cancelConnect  error");
    });
    isConnectState = false;
    refreshState();
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

  void monitorCharacter() {
    FlutterBleLib.instance
        .monitorCharacteristicForDevice(_macAddress, serviceUUID,
            characteristicUUID, "monitorCharacteristic")
        .listen((event) {});
  }
}
