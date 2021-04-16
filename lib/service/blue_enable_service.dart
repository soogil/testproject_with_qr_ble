import 'package:bluetooth_plugin/bluetooth_plugin.dart';

class BluetoothEnableService {
  static final BluetoothEnableService _instance = BluetoothEnableService._internal();

  factory BluetoothEnableService() => _instance;

  BluetoothEnableService._internal() {
    isEnabledBluetooth.then((value) => _isEnable = value);
  }

  bool _isEnable;

  Future get useBluetoothEnable => BluetoothPlugin.useBluetooth;

  Future get isEnabledBluetooth async => await BluetoothPlugin.isEnabled;

  bool get isEnable => _isEnable;
}