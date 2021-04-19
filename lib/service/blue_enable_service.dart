import 'dart:async';

import 'package:bluetooth_plugin/bluetooth_plugin.dart';

class BluetoothEnableService {
  static final BluetoothEnableService _instance = BluetoothEnableService._internal();

  factory BluetoothEnableService() => _instance;

  BluetoothEnableService._internal() {
    BluetoothPlugin.detectingBluetoothStatus(_bluetoothStateController);
  }

  StreamController _bluetoothStateController = StreamController();

  dispose() {
    _bluetoothStateController.close();
  }

  Future get changeBluetoothState => BluetoothPlugin.changeBluetoothState;

  Future<bool> get isBluetoothEnabled async => await BluetoothPlugin.isBluetoothEnabled;

  Future<bool> get isLocationEnabled async => await BluetoothPlugin.isLocationEnabled;

  Stream get bluetoothStateStream => _bluetoothStateController.stream;

  static BluetoothEnableService get instance => _instance;
}