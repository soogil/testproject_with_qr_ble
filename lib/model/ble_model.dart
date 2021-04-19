import 'package:equatable/equatable.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BleModel extends Equatable {
  BleModel(ScanResult scanResult)
      : this.id = scanResult.peripheral.identifier,
        this.deviceName = scanResult.peripheral.name ??
            scanResult.advertisementData.localName ?? 'Unknown',
        this._rssi = scanResult.rssi,
        this.isConnected = false,
        this.advertisementData = scanResult.advertisementData,
        this.peripheral = scanResult.peripheral;

  final String id;
  final String deviceName;
  final int _rssi;
  final bool isConnected;
  final AdvertisementData advertisementData;
  final Peripheral peripheral;

  String get rssi => _rssi.toString();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}