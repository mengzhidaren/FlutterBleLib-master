///
//  Generated code. Do not modify.
//  source: bledata.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, String;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart' as $pb;

export 'bledata.pbenum.dart';

class ScanDataMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScanDataMessage')
    ..a<$core.int>(1, 'scanMode', $pb.PbFieldType.O3)
    ..a<$core.int>(2, 'callbackType', $pb.PbFieldType.O3)
    ..pPS(3, 'uuids')
    ..hasRequiredFields = false
  ;

  ScanDataMessage() : super();
  ScanDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ScanDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ScanDataMessage clone() => ScanDataMessage()..mergeFromMessage(this);
  ScanDataMessage copyWith(void Function(ScanDataMessage) updates) => super.copyWith((message) => updates(message as ScanDataMessage));
  $pb.BuilderInfo get info_ => _i;
  static ScanDataMessage create() => ScanDataMessage();
  ScanDataMessage createEmptyInstance() => create();
  static $pb.PbList<ScanDataMessage> createRepeated() => $pb.PbList<ScanDataMessage>();
  static ScanDataMessage getDefault() => _defaultInstance ??= create()..freeze();
  static ScanDataMessage _defaultInstance;

  $core.int get scanMode => $_get(0, 0);
  set scanMode($core.int v) { $_setSignedInt32(0, v); }
  $core.bool hasScanMode() => $_has(0);
  void clearScanMode() => clearField(1);

  $core.int get callbackType => $_get(1, 0);
  set callbackType($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasCallbackType() => $_has(1);
  void clearCallbackType() => clearField(2);

  $core.List<$core.String> get uuids => $_getList(2);
}

class BleDeviceMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('BleDeviceMessage')
    ..aOS(1, 'id')
    ..aOS(2, 'name')
    ..a<$core.int>(3, 'rssi', $pb.PbFieldType.O3)
    ..a<$core.int>(4, 'mtu', $pb.PbFieldType.O3)
    ..aOB(5, 'isConnected')
    ..hasRequiredFields = false
  ;

  BleDeviceMessage() : super();
  BleDeviceMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  BleDeviceMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  BleDeviceMessage clone() => BleDeviceMessage()..mergeFromMessage(this);
  BleDeviceMessage copyWith(void Function(BleDeviceMessage) updates) => super.copyWith((message) => updates(message as BleDeviceMessage));
  $pb.BuilderInfo get info_ => _i;
  static BleDeviceMessage create() => BleDeviceMessage();
  BleDeviceMessage createEmptyInstance() => create();
  static $pb.PbList<BleDeviceMessage> createRepeated() => $pb.PbList<BleDeviceMessage>();
  static BleDeviceMessage getDefault() => _defaultInstance ??= create()..freeze();
  static BleDeviceMessage _defaultInstance;

  $core.String get id => $_getS(0, '');
  set id($core.String v) { $_setString(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get name => $_getS(1, '');
  set name($core.String v) { $_setString(1, v); }
  $core.bool hasName() => $_has(1);
  void clearName() => clearField(2);

  $core.int get rssi => $_get(2, 0);
  set rssi($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasRssi() => $_has(2);
  void clearRssi() => clearField(3);

  $core.int get mtu => $_get(3, 0);
  set mtu($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasMtu() => $_has(3);
  void clearMtu() => clearField(4);

  $core.bool get isConnected => $_get(4, false);
  set isConnected($core.bool v) { $_setBool(4, v); }
  $core.bool hasIsConnected() => $_has(4);
  void clearIsConnected() => clearField(5);
}

class ScanResultMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ScanResultMessage')
    ..a<BleDeviceMessage>(1, 'bleDeviceMessage', $pb.PbFieldType.OM, BleDeviceMessage.getDefault, BleDeviceMessage.create)
    ..a<$core.int>(2, 'rssi', $pb.PbFieldType.O3)
    ..a<Int64>(3, 'timestampNanos', $pb.PbFieldType.OU6, Int64.ZERO)
    ..a<$core.int>(4, 'scanCallbackTypeMessage', $pb.PbFieldType.O3)
    ..p<$core.List<$core.int>>(5, 'scanRecord', $pb.PbFieldType.PY)
    ..hasRequiredFields = false
  ;

  ScanResultMessage() : super();
  ScanResultMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ScanResultMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ScanResultMessage clone() => ScanResultMessage()..mergeFromMessage(this);
  ScanResultMessage copyWith(void Function(ScanResultMessage) updates) => super.copyWith((message) => updates(message as ScanResultMessage));
  $pb.BuilderInfo get info_ => _i;
  static ScanResultMessage create() => ScanResultMessage();
  ScanResultMessage createEmptyInstance() => create();
  static $pb.PbList<ScanResultMessage> createRepeated() => $pb.PbList<ScanResultMessage>();
  static ScanResultMessage getDefault() => _defaultInstance ??= create()..freeze();
  static ScanResultMessage _defaultInstance;

  BleDeviceMessage get bleDeviceMessage => $_getN(0);
  set bleDeviceMessage(BleDeviceMessage v) { setField(1, v); }
  $core.bool hasBleDeviceMessage() => $_has(0);
  void clearBleDeviceMessage() => clearField(1);

  $core.int get rssi => $_get(1, 0);
  set rssi($core.int v) { $_setSignedInt32(1, v); }
  $core.bool hasRssi() => $_has(1);
  void clearRssi() => clearField(2);

  Int64 get timestampNanos => $_getI64(2);
  set timestampNanos(Int64 v) { $_setInt64(2, v); }
  $core.bool hasTimestampNanos() => $_has(2);
  void clearTimestampNanos() => clearField(3);

  $core.int get scanCallbackTypeMessage => $_get(3, 0);
  set scanCallbackTypeMessage($core.int v) { $_setSignedInt32(3, v); }
  $core.bool hasScanCallbackTypeMessage() => $_has(3);
  void clearScanCallbackTypeMessage() => clearField(4);

  $core.List<$core.List<$core.int>> get scanRecord => $_getList(4);
}

class ConnectToDeviceDataMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConnectToDeviceDataMessage')
    ..aOS(1, 'macAddress')
    ..aOB(2, 'isAutoConnect')
    ..a<$core.int>(3, 'requestMtu', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  ConnectToDeviceDataMessage() : super();
  ConnectToDeviceDataMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ConnectToDeviceDataMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ConnectToDeviceDataMessage clone() => ConnectToDeviceDataMessage()..mergeFromMessage(this);
  ConnectToDeviceDataMessage copyWith(void Function(ConnectToDeviceDataMessage) updates) => super.copyWith((message) => updates(message as ConnectToDeviceDataMessage));
  $pb.BuilderInfo get info_ => _i;
  static ConnectToDeviceDataMessage create() => ConnectToDeviceDataMessage();
  ConnectToDeviceDataMessage createEmptyInstance() => create();
  static $pb.PbList<ConnectToDeviceDataMessage> createRepeated() => $pb.PbList<ConnectToDeviceDataMessage>();
  static ConnectToDeviceDataMessage getDefault() => _defaultInstance ??= create()..freeze();
  static ConnectToDeviceDataMessage _defaultInstance;

  $core.String get macAddress => $_getS(0, '');
  set macAddress($core.String v) { $_setString(0, v); }
  $core.bool hasMacAddress() => $_has(0);
  void clearMacAddress() => clearField(1);

  $core.bool get isAutoConnect => $_get(1, false);
  set isAutoConnect($core.bool v) { $_setBool(1, v); }
  $core.bool hasIsAutoConnect() => $_has(1);
  void clearIsAutoConnect() => clearField(2);

  $core.int get requestMtu => $_get(2, 0);
  set requestMtu($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasRequestMtu() => $_has(2);
  void clearRequestMtu() => clearField(3);
}

class ServiceMessages extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ServiceMessages')
    ..pc<ServiceMessage>(1, 'serviceMessages', $pb.PbFieldType.PM,ServiceMessage.create)
    ..hasRequiredFields = false
  ;

  ServiceMessages() : super();
  ServiceMessages.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceMessages.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceMessages clone() => ServiceMessages()..mergeFromMessage(this);
  ServiceMessages copyWith(void Function(ServiceMessages) updates) => super.copyWith((message) => updates(message as ServiceMessages));
  $pb.BuilderInfo get info_ => _i;
  static ServiceMessages create() => ServiceMessages();
  ServiceMessages createEmptyInstance() => create();
  static $pb.PbList<ServiceMessages> createRepeated() => $pb.PbList<ServiceMessages>();
  static ServiceMessages getDefault() => _defaultInstance ??= create()..freeze();
  static ServiceMessages _defaultInstance;

  $core.List<ServiceMessage> get serviceMessages => $_getList(0);
}

class ServiceMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ServiceMessage')
    ..a<$core.double>(1, 'id', $pb.PbFieldType.OD)
    ..aOS(2, 'uuid')
    ..a<BleDeviceMessage>(3, 'device', $pb.PbFieldType.OM, BleDeviceMessage.getDefault, BleDeviceMessage.create)
    ..aOB(4, 'isPrimary')
    ..hasRequiredFields = false
  ;

  ServiceMessage() : super();
  ServiceMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ServiceMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ServiceMessage clone() => ServiceMessage()..mergeFromMessage(this);
  ServiceMessage copyWith(void Function(ServiceMessage) updates) => super.copyWith((message) => updates(message as ServiceMessage));
  $pb.BuilderInfo get info_ => _i;
  static ServiceMessage create() => ServiceMessage();
  ServiceMessage createEmptyInstance() => create();
  static $pb.PbList<ServiceMessage> createRepeated() => $pb.PbList<ServiceMessage>();
  static ServiceMessage getDefault() => _defaultInstance ??= create()..freeze();
  static ServiceMessage _defaultInstance;

  $core.double get id => $_getN(0);
  set id($core.double v) { $_setDouble(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get uuid => $_getS(1, '');
  set uuid($core.String v) { $_setString(1, v); }
  $core.bool hasUuid() => $_has(1);
  void clearUuid() => clearField(2);

  BleDeviceMessage get device => $_getN(2);
  set device(BleDeviceMessage v) { setField(3, v); }
  $core.bool hasDevice() => $_has(2);
  void clearDevice() => clearField(3);

  $core.bool get isPrimary => $_get(3, false);
  set isPrimary($core.bool v) { $_setBool(3, v); }
  $core.bool hasIsPrimary() => $_has(3);
  void clearIsPrimary() => clearField(4);
}

class CharacteristicMessages extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CharacteristicMessages')
    ..pc<CharacteristicMessage>(1, 'characteristicMessage', $pb.PbFieldType.PM,CharacteristicMessage.create)
    ..hasRequiredFields = false
  ;

  CharacteristicMessages() : super();
  CharacteristicMessages.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CharacteristicMessages.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CharacteristicMessages clone() => CharacteristicMessages()..mergeFromMessage(this);
  CharacteristicMessages copyWith(void Function(CharacteristicMessages) updates) => super.copyWith((message) => updates(message as CharacteristicMessages));
  $pb.BuilderInfo get info_ => _i;
  static CharacteristicMessages create() => CharacteristicMessages();
  CharacteristicMessages createEmptyInstance() => create();
  static $pb.PbList<CharacteristicMessages> createRepeated() => $pb.PbList<CharacteristicMessages>();
  static CharacteristicMessages getDefault() => _defaultInstance ??= create()..freeze();
  static CharacteristicMessages _defaultInstance;

  $core.List<CharacteristicMessage> get characteristicMessage => $_getList(0);
}

class CharacteristicMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('CharacteristicMessage')
    ..a<$core.double>(1, 'id', $pb.PbFieldType.OD)
    ..aOS(2, 'uuid')
    ..a<$core.int>(3, 'serviceId', $pb.PbFieldType.O3)
    ..aOS(4, 'serviceUuid')
    ..aOS(5, 'deviceId')
    ..aOB(6, 'isReadable')
    ..aOB(7, 'isWritableWithResponse')
    ..aOB(8, 'isWritableWithoutResponse')
    ..aOB(9, 'isNotificable')
    ..aOB(10, 'isIndicatable')
    ..aOB(11, 'isNotifing')
    ..aOS(12, 'value')
    ..hasRequiredFields = false
  ;

  CharacteristicMessage() : super();
  CharacteristicMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  CharacteristicMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  CharacteristicMessage clone() => CharacteristicMessage()..mergeFromMessage(this);
  CharacteristicMessage copyWith(void Function(CharacteristicMessage) updates) => super.copyWith((message) => updates(message as CharacteristicMessage));
  $pb.BuilderInfo get info_ => _i;
  static CharacteristicMessage create() => CharacteristicMessage();
  CharacteristicMessage createEmptyInstance() => create();
  static $pb.PbList<CharacteristicMessage> createRepeated() => $pb.PbList<CharacteristicMessage>();
  static CharacteristicMessage getDefault() => _defaultInstance ??= create()..freeze();
  static CharacteristicMessage _defaultInstance;

  $core.double get id => $_getN(0);
  set id($core.double v) { $_setDouble(0, v); }
  $core.bool hasId() => $_has(0);
  void clearId() => clearField(1);

  $core.String get uuid => $_getS(1, '');
  set uuid($core.String v) { $_setString(1, v); }
  $core.bool hasUuid() => $_has(1);
  void clearUuid() => clearField(2);

  $core.int get serviceId => $_get(2, 0);
  set serviceId($core.int v) { $_setSignedInt32(2, v); }
  $core.bool hasServiceId() => $_has(2);
  void clearServiceId() => clearField(3);

  $core.String get serviceUuid => $_getS(3, '');
  set serviceUuid($core.String v) { $_setString(3, v); }
  $core.bool hasServiceUuid() => $_has(3);
  void clearServiceUuid() => clearField(4);

  $core.String get deviceId => $_getS(4, '');
  set deviceId($core.String v) { $_setString(4, v); }
  $core.bool hasDeviceId() => $_has(4);
  void clearDeviceId() => clearField(5);

  $core.bool get isReadable => $_get(5, false);
  set isReadable($core.bool v) { $_setBool(5, v); }
  $core.bool hasIsReadable() => $_has(5);
  void clearIsReadable() => clearField(6);

  $core.bool get isWritableWithResponse => $_get(6, false);
  set isWritableWithResponse($core.bool v) { $_setBool(6, v); }
  $core.bool hasIsWritableWithResponse() => $_has(6);
  void clearIsWritableWithResponse() => clearField(7);

  $core.bool get isWritableWithoutResponse => $_get(7, false);
  set isWritableWithoutResponse($core.bool v) { $_setBool(7, v); }
  $core.bool hasIsWritableWithoutResponse() => $_has(7);
  void clearIsWritableWithoutResponse() => clearField(8);

  $core.bool get isNotificable => $_get(8, false);
  set isNotificable($core.bool v) { $_setBool(8, v); }
  $core.bool hasIsNotificable() => $_has(8);
  void clearIsNotificable() => clearField(9);

  $core.bool get isIndicatable => $_get(9, false);
  set isIndicatable($core.bool v) { $_setBool(9, v); }
  $core.bool hasIsIndicatable() => $_has(9);
  void clearIsIndicatable() => clearField(10);

  $core.bool get isNotifing => $_get(10, false);
  set isNotifing($core.bool v) { $_setBool(10, v); }
  $core.bool hasIsNotifing() => $_has(10);
  void clearIsNotifing() => clearField(11);

  $core.String get value => $_getS(11, '');
  set value($core.String v) { $_setString(11, v); }
  $core.bool hasValue() => $_has(11);
  void clearValue() => clearField(12);
}

class MonitorCharacteristicMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MonitorCharacteristicMessage')
    ..aOS(1, 'transactionId')
    ..a<CharacteristicMessage>(2, 'characteristicMessage', $pb.PbFieldType.OM, CharacteristicMessage.getDefault, CharacteristicMessage.create)
    ..hasRequiredFields = false
  ;

  MonitorCharacteristicMessage() : super();
  MonitorCharacteristicMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  MonitorCharacteristicMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  MonitorCharacteristicMessage clone() => MonitorCharacteristicMessage()..mergeFromMessage(this);
  MonitorCharacteristicMessage copyWith(void Function(MonitorCharacteristicMessage) updates) => super.copyWith((message) => updates(message as MonitorCharacteristicMessage));
  $pb.BuilderInfo get info_ => _i;
  static MonitorCharacteristicMessage create() => MonitorCharacteristicMessage();
  MonitorCharacteristicMessage createEmptyInstance() => create();
  static $pb.PbList<MonitorCharacteristicMessage> createRepeated() => $pb.PbList<MonitorCharacteristicMessage>();
  static MonitorCharacteristicMessage getDefault() => _defaultInstance ??= create()..freeze();
  static MonitorCharacteristicMessage _defaultInstance;

  $core.String get transactionId => $_getS(0, '');
  set transactionId($core.String v) { $_setString(0, v); }
  $core.bool hasTransactionId() => $_has(0);
  void clearTransactionId() => clearField(1);

  CharacteristicMessage get characteristicMessage => $_getN(1);
  set characteristicMessage(CharacteristicMessage v) { setField(2, v); }
  $core.bool hasCharacteristicMessage() => $_has(1);
  void clearCharacteristicMessage() => clearField(2);
}

