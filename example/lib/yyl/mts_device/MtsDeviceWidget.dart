import 'package:flutter/material.dart';
import 'package:flutter_ble_lib_example/yyl/mts_device/MtsDevice.dart';

class MtsDeviceWidget extends StatefulWidget {
  String _macAddress;

  MtsDeviceWidget(this._macAddress);

  @override
  State<StatefulWidget> createState() {
    return MtsDeviceWidgetState(_macAddress);
  }
}

class MtsDeviceWidgetState extends State<MtsDeviceWidget> {
  String _macAddress;

  MtsDeviceWidgetState(this._macAddress);

  MtsDevice mtsDevice;
  double speed = 1;
  double flow = 1;
  bool modeState = true;
  bool isConnectState = false;

  @override
  void initState() {
    super.initState();
    mtsDevice = MtsDevice(_macAddress);
    mtsDevice.refreshUI = () => setState(() {
          isConnectState = mtsDevice.isConnectState;
          speed = mtsDevice.mtsData.speed.toDouble();
          flow = mtsDevice.mtsData.flow.toDouble();
          modeState = mtsDevice.mtsData.mode == 1;
        });
  }

  @override
  void dispose() {
    mtsDevice.cancelConnect(true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Colors.blueGrey,
        title: new Text('mac=$_macAddress'),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(40),
              child: Icon(
                isConnectState
                    ? Icons.bluetooth_connected
                    : Icons.bluetooth_disabled,
                color: Colors.blue,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: buttonConnect,
                  child: Text('connect'),
                ),
                RaisedButton(
                  onPressed: cancelConnect,
                  child: Text('cancelConnect'),
                ),
              ],
            ),
            RaisedButton(
                onPressed: buttonStart,
                child: new Text(
                  "start",
                )),
            RaisedButton(
                onPressed: buttonStop,
                child: new Text(
                  "stop",
                )),
            Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "速度",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Slider(
                onChanged: (value) {
                  setState(() {
                    speed = value;
                  });
                },
                value: speed,
                divisions: 20,
                min: 0,
                max: 20,
                onChangeEnd: onChangeSpeedEnd,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Text(
                "流量",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: Slider(
                onChanged: (value) {
                  setState(() {
                    flow = value;
                  });
                },
                value: flow,
                divisions: 20,
                min: 0,
                max: 20,
                onChangeEnd: onChangeFlowEnd,
              ),
            ),
//            Padding(
//              padding: EdgeInsets.all(3),
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.start,
//                children: <Widget>[
//                  CheckboxListTile(
//                    value: modeState,
//                    title: const Text("自动"),
//                    onChanged: (bool value) {
//                      //   onChangeMode(check);
//                    },
//                    secondary: const Icon(Icons.check_box),
//                  ),
//                  CheckboxListTile(
//                    value: !modeState,
//                    title: Text("手动"),
//                    onChanged: (check) {
//                      onChangeMode(!check);
//                    },
//                  ),
//                ],
//              ),
//            ),
          ]),
    );
  }

  void onChangeMode(bool isAuto) {
    setState(() {
      modeState = isAuto;
    });
    print(modeState ? 1 : 2);
    mtsDevice.setMode(modeState ? 1 : 2);
  }

  void onChangeSpeedEnd(double value) {
    speed = value;
    mtsDevice.setSpeed(value.toInt());
  }

  void onChangeFlowEnd(double value) {
    flow = value;
    mtsDevice.setSlow(value.toInt());
  }

  void buttonConnect() {
    mtsDevice.connect();
  }

  void cancelConnect() {
    mtsDevice.cancelConnect(false);
  }

  void buttonStart() {
    mtsDevice.sendStart();
  }

  void buttonStop() {
    mtsDevice.sendStop();
  }
}
