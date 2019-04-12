import 'package:flutter/material.dart';
import 'package:flutter_ble_lib_example/yyl/hog_device/SuctionDevice.dart';

class SuctionDeviceWidget extends StatefulWidget {
  String _macAddress;

  SuctionDeviceWidget(this._macAddress);

  @override
  State<StatefulWidget> createState() {
    return SuctionDeviceWidgetState(_macAddress);
  }
}

class SuctionDeviceWidgetState extends State<SuctionDeviceWidget> {
  String _macAddress;

  SuctionDeviceWidgetState(this._macAddress);

  SuctionDevice suctionDevice;
  double sliderValue = 1;
  bool isConnectState = false;
  @override
  void initState() {
    super.initState();
    suctionDevice = SuctionDevice(_macAddress);
    suctionDevice.refreshUI = () => setState(() {
          isConnectState = suctionDevice.isConnectState;
        });
  }

  @override
  void dispose() {
    suctionDevice.cancelConnect();
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
              padding: EdgeInsets.fromLTRB(40, 60, 40, 20),
              child: Slider(
                onChanged: sliderChanged,
                value: sliderValue,
                divisions: 7,
                min: 0,
                max: 7,
                onChangeEnd: onChangeEnd,
              ),
            ),
          ]),
    );
  }

  void onChangeEnd(double value) {
    suctionDevice.sendP(value.toInt());
  }

  void sliderChanged(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  void buttonConnect() {
    suctionDevice.connect();
  }

  void cancelConnect() {
    suctionDevice.cancelConnect();
  }

  void buttonStart() {
    suctionDevice.sendStart();
  }

  void buttonStop() {
    suctionDevice.sendStop();
  }
}
