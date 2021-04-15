import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothModel extends Equatable {
  BluetoothModel(ScanResult scanResult)
      : this.id = scanResult.device.id.toString(),
        this.deviceName = scanResult.device.name == null ||
            scanResult.device.name  == '' ? 'Unknown' : scanResult.device.name,
        this._rssi = scanResult.rssi,
        this.isConnected = false,
        this.advertisementData = scanResult.advertisementData;

  final String id;
  final String deviceName;
  final int _rssi;
  final bool isConnected;
  final AdvertisementData advertisementData;

  String get rssi => _rssi.toString();

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id];
}