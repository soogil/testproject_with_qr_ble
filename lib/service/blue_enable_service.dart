import 'dart:async';

import 'package:bluetooth_plugin/bluetooth_plugin.dart';

class BluetoothEnableService {
  static final BluetoothEnableService _instance = BluetoothEnableService._internal();

  factory BluetoothEnableService() => _instance;

  BluetoothEnableService._internal() {
    isBluetoothEnabled.then((value) {
      _isEnable = value;
      print('BluetoothEnableService $_isEnable');
    });
    BluetoothPlugin.detectingBluetoothStatus(_bluetoothStateController);
  }

  StreamController _bluetoothStateController = StreamController();

  dispose() {
    _bluetoothStateController.close();
  }

  bool _isEnable;

  Future get changeBluetoothState => BluetoothPlugin.useBluetooth;

  Future<bool> get isBluetoothEnabled async => await BluetoothPlugin.isBluetoothEnabled;

  Future<bool> get isLocationEnabled async => await BluetoothPlugin.isLocationEnabled;

  Stream get bluetoothStateStream => _bluetoothStateController.stream;

  bool get isEnable => _isEnable;

  static BluetoothEnableService get instance => _instance;
}