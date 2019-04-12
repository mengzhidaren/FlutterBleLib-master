import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_ble_lib_example/ui/ble_connected_device_screen.dart';
import 'package:flutter_ble_lib_example/ui/log_level_dialog.dart';
import 'package:flutter_ble_lib_example/yyl/hog_device/SuctionDeviceWidget.dart';
import 'package:flutter_ble_lib_example/yyl/Jdy.dart';
import 'package:flutter_ble_lib_example/yyl/mts_device/MtsDeviceWidget.dart';

class BleScanResultList extends StatefulWidget {
  final List<ScanResult> _scanResults;

  final BuildContext _mainBuildContext;

  BleScanResultList(this._scanResults, this._mainBuildContext);

  @override
  State<StatefulWidget> createState() =>
      new BleScanResultListState(_scanResults, _mainBuildContext);
}

class ScanResultItem extends StatelessWidget {
  final ScanResult _scanResult;
  final VoidCallback _onIsConnectedClick;
  final VoidCallback _onConnectClick;

  ScanResultItem(
    this._scanResult,
    this._onIsConnectedClick,
    this._onConnectClick,
  );

  Color getColorJdy() {
    if (getJdystate(_scanResult.scanRecord)) {
      return Colors.yellow;
    } else {
      return Color.fromRGBO(69, 90, 100, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.title;
    final TextStyle body1Style = Theme.of(context).textTheme.body1;
    final TextStyle body2Style = Theme.of(context).textTheme.body2;
    final TextStyle buttonStyle = Theme.of(context).textTheme.body2;
//    final colorjdy=const Color.fromRGBO(69, 90, 100, 1.0);

    return new Card(
      color: getColorJdy(),
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              "Scan Result : ",
              style: titleStyle,
            ),
            new Text(
              _scanResultLabelInfo(),
              style: body1Style,
            ),
            new Text(_deviceDataLabel(), style: body2Style),
            new Container(
              margin: const EdgeInsets.only(top: 12.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    child: new MaterialButton(
                      onPressed: _onIsConnectedClick,
                      color: Colors.blueAccent,
                      child: new Text("IS CONNECTED", style: buttonStyle),
                    ),
                  ),
                  new MaterialButton(
                    onPressed: _onConnectClick,
                    color: Colors.blueAccent,
                    child: new Text(
                      "CONNECT",
                      style: buttonStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _scanResultLabelInfo() => "RSSI : ${_scanResult.rssi}\n"
      "Timestamp nanos : ${_scanResult.timestampNanos}\n"
      "Scan callback type : ${_scanResult.scanCallbackType}\n"
      "scanRecord : ${_scanResult.scanRecord}\n"
      "BleDevice";

  _deviceDataLabel() => "\tname : ${_scanResult.bleDevice.name}\n\t"
      "mac address : ${_scanResult.bleDevice.id}\n\t"
      "is connected : ${_scanResult.bleDevice.isConnected}";
}

class BleScanResultListState extends State<StatefulWidget> {
  final List<ScanResult> _scanResults;

  final BuildContext _mainBuildContext;

  BleScanResultListState(this._scanResults, this._mainBuildContext);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: _scanResults == null ? 0 : _scanResults.length,
        itemBuilder: (BuildContext context, int index) =>
            buildItem(_scanResults[index], _mainBuildContext));
  }

  Widget buildItem(ScanResult scanResults, BuildContext context) {
    return new ScanResultItem(
        scanResults,
        () => _onIsConnectedButtonClick(scanResults),
        () => _onConnectButtonClick(scanResults));
  }

  _onConnectButtonClick(ScanResult scanResult) {
//    FlutterBleLib.instance
//        .connectToDevice(scanResults.bleDevice.id, isAutoConnect: true)
//        .then((connectedDevice) => Navigator.of(_mainBuildContext).push(
//            new MaterialPageRoute(
//                builder: (BuildContext buildContext) =>
//                    new BleConnectedDeviceScreen(connectedDevice))));

    Navigator.of(_mainBuildContext).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            MtsDeviceWidget(scanResult.bleDevice.id)));
  }

  _onIsConnectedButtonClick(ScanResult scanResult) {
//    FlutterBleLib.instance
//        .isDeviceConnected(scanResult.bleDevice.id)
//        .then((isConnected) =>
//        setState(() => scanResult.bleDevice.isConnected = isConnected));
    Navigator.of(_mainBuildContext).push(MaterialPageRoute(
        builder: (BuildContext context) =>
            SuctionDeviceWidget(scanResult.bleDevice.id)));
  }
}

class BleDevicesScreen extends StatefulWidget {
  @override
  BleDevicesState createState() => new BleDevicesState();
}

class BleDevicesState extends State<BleDevicesScreen> {
  StreamSubscription _scanDevicesSub;
  StreamSubscription _bluetoothStateSub;

  bool _isScan = false;
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final List<ScanResult> _scanResults = new List();

  @override
  initState() {
    super.initState();
    //yyl
    FlutterBleLib.instance.createClient(null);

    _bluetoothStateSub = FlutterBleLib.instance.onStateChange().listen(
        (bluetoothState) =>
            setState(() => this._bluetoothState = bluetoothState));
    FlutterBleLib.instance.state().then((bluetoothState) =>
        setState(() => this._bluetoothState = bluetoothState));
  }

  @override
  dispose() {
    _onStopScan();
    _cancelStateChange();
    FlutterBleLib.instance.destroyClient();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = Theme.of(context).textTheme.button;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text('Scan List'),
        actions: <Widget>[
          new IconButton(
            // action button
            icon: new Icon(Icons.settings),
            onPressed: () =>
                showDialog(context: context, child: new LogLevelDialog()),
          ),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(_isScan ? Icons.close : Icons.search),
        onPressed: _isScan ? _onStopScan : _onStartScan,
      ),
      body: new BleScanResultList(_scanResults, context),
      bottomNavigationBar: new PreferredSize(
        preferredSize: const Size.fromHeight(24.0),
        child: new Theme(
          data: Theme.of(context).copyWith(
              accentColor: Colors.white, backgroundColor: Colors.blueGrey),
          child: new Container(
            color: Colors.blueGrey,
            padding: const EdgeInsets.all(10.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("Bluetooth state", style: style),
                new Icon(
                  _bleStateIcon(),
                  size: 20.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bleStateIcon() {
    switch (_bluetoothState) {
      case BluetoothState.UNKNOWN:
        return Icons.device_unknown;
      case BluetoothState.RESETTING:
        return Icons.bluetooth_searching;
      case BluetoothState.UNSUPPORTED:
        return Icons.close;
      case BluetoothState.UNAUTHORIZED:
        return Icons.lock;
      case BluetoothState.POWERED_OFF:
        return Icons.bluetooth_disabled;
      case BluetoothState.POWERED_ON:
        return Icons.bluetooth;
    }
  }

  _cancelStateChange() {
    _bluetoothStateSub?.cancel();
    _bluetoothStateSub = null;
  }

  _onStopScan() {
    _scanDevicesSub?.cancel();
    _scanDevicesSub = null;
    FlutterBleLib.instance.stopDeviceScan();
    setState(() {
      _isScan = false;
    });
  }

  _onStartScan() {
    //TODO pass this list as arg to scan only filtered devices
//    List<String> uuids = new List();
//    uuids.add("0000181d-0000-1000-8000-00805f9b34fb");

    _scanDevicesSub = FlutterBleLib.instance
        .startDeviceScan(1, 1, null /*uuids*/)
        .listen(
            (scanResult) => setState(() => _addOrUpdateIfNecessary(scanResult)),
            onDone: _onStopScan);

    setState(() {
      _isScan = true;
    });
  }

  _addOrUpdateIfNecessary(ScanResult scanResultItem) {
    for (var scanResult in _scanResults) {
      if (scanResult.hasTheSameDeviceAs(scanResultItem)) {
        scanResult.update(scanResultItem);
        return;
      }
    }
    if (getJdystate(scanResultItem.scanRecord)) {
      _scanResults.add(scanResultItem);
    }
//    if(scanResultItem.scanRecord)
  }
}
