///
//  Generated code. Do not modify.
//  source: bledata.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core show int, dynamic, String, List, Map;
import 'package:protobuf/protobuf.dart' as $pb;

class LogLevelMessage extends $pb.ProtobufEnum {
  static const LogLevelMessage VERBOSE = LogLevelMessage._(0, 'VERBOSE');
  static const LogLevelMessage DEBUG = LogLevelMessage._(1, 'DEBUG');
  static const LogLevelMessage INFO = LogLevelMessage._(2, 'INFO');
  static const LogLevelMessage WARNING = LogLevelMessage._(3, 'WARNING');
  static const LogLevelMessage ERROR = LogLevelMessage._(4, 'ERROR');
  static const LogLevelMessage NONE = LogLevelMessage._(5, 'NONE');

  static const $core.List<LogLevelMessage> values = <LogLevelMessage> [
    VERBOSE,
    DEBUG,
    INFO,
    WARNING,
    ERROR,
    NONE,
  ];

  static final $core.Map<$core.int, LogLevelMessage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static LogLevelMessage valueOf($core.int value) => _byValue[value];

  const LogLevelMessage._($core.int v, $core.String n) : super(v, n);
}

class BluetoothStateMessage extends $pb.ProtobufEnum {
  static const BluetoothStateMessage UNKNOWN = BluetoothStateMessage._(0, 'UNKNOWN');
  static const BluetoothStateMessage RESETTING = BluetoothStateMessage._(1, 'RESETTING');
  static const BluetoothStateMessage UNSUPPORTED = BluetoothStateMessage._(2, 'UNSUPPORTED');
  static const BluetoothStateMessage UNAUTHORIZED = BluetoothStateMessage._(3, 'UNAUTHORIZED');
  static const BluetoothStateMessage POWERED_OFF = BluetoothStateMessage._(4, 'POWERED_OFF');
  static const BluetoothStateMessage POWERED_ON = BluetoothStateMessage._(5, 'POWERED_ON');

  static const $core.List<BluetoothStateMessage> values = <BluetoothStateMessage> [
    UNKNOWN,
    RESETTING,
    UNSUPPORTED,
    UNAUTHORIZED,
    POWERED_OFF,
    POWERED_ON,
  ];

  static final $core.Map<$core.int, BluetoothStateMessage> _byValue = $pb.ProtobufEnum.initByValue(values);
  static BluetoothStateMessage valueOf($core.int value) => _byValue[value];

  const BluetoothStateMessage._($core.int v, $core.String n) : super(v, n);
}

