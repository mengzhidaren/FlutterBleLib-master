library utils_jdy;

class JDY {
  static final serviceUUID = "0000ffe0-0000-1000-8000-00805f9b34fb";
  static final characteristicUUID = "0000ffe1-0000-1000-8000-00805f9b34fb";

  //每次获取新的数组
  final connectData = [
    0xaa, 0xa5, 0x14, 0x00, 0x00, 0x00, // start 0
    0x00, 0x00, 0x00, 0x00, 0x00, // start 6
    0x00, 0x00, 0x00, 0x00, 0x00, // start 11
    0x00, 0x01, 0xcc, 0x35 // start 16
  ];
  final controlIndex = 5;
  final controlTime = 16;

  void checkNumb(int value, int min, int max) {
    if (value < min || value > max) {
      throw Exception("value is$value   mast be in $min .. $max  is error");
    }
  }

  List<int> sendStart() {
    connectData[controlIndex] = 0x01;
    connectData[controlTime] = 0xff;
    return connectData;
  }

  List<int> sendPause() {
    connectData[controlIndex] = 0x02;
    connectData[controlTime] = 0xff;
    return connectData;
  }

  List<int> setHogPressure(int pressure) {
    checkNumb(pressure, 0, 8);
    connectData[controlIndex] = 0x16;
    connectData[controlTime] = 0xff;
    connectData[7] = pressure;
    return connectData;
  }

  List<int> sendMts(int speed, int flow, int mode) {
    checkNumb(speed, 0, 20);
    checkNumb(flow, 0, 20);
    checkNumb(mode, 1, 2);
    connectData[controlIndex] = 0x17;
    connectData[controlTime] = 0xff;
    connectData[7] = speed;
    connectData[8] = flow;
    connectData[9] = mode;
    return connectData;
  }
}

bool getJdystate(List<List<int>> dataList) {
  if (dataList == null || dataList.length == 0) return false;
  var byteArray = dataList[0];
  if (byteArray.length != 62) return false;
  var m1 = ((byteArray[18 + 2] + 1) ^ 0x11).toInt();
  var m2 = ((byteArray[17 + 2] + 1) ^ 0x22).toInt();

  var ib1_major = 0;
  var ib1_minor = 0;
  if (byteArray[52] == 0xff.toInt()) {
    if (byteArray[53] == 0xff.toInt()) ib1_major = 1;
  }
  if (byteArray[54] == 0xff.toInt()) {
    if (byteArray[55] == 0xff.toInt()) ib1_minor = 1;
  }
  if (byteArray[5] == 0xe0.toInt() &&
      byteArray[6] == 0xff.toInt() &&
      byteArray[11] == m1 &&
      byteArray[12] == m2 &&
      0x88.toInt() == byteArray[19 - 6]) {
    return true;
  } else if (byteArray[44] == 0x10.toInt() &&
      byteArray[45] == 0x16.toInt() &&
      (ib1_major == 1 || ib1_minor == 1)) {
    return true;
  } else if (byteArray[3] == 0x1a.toInt() && byteArray[4] == 0xff.toInt()) {
    return true;
  }
  return false;
}
