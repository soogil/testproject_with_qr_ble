import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BleService {
  static final BleService _instance = BleService._internal();

  factory BleService() => _instance;

  BleService._internal();

  final BleManager _bleManager = BleManager();

  Future createClient() async => await _bleManager.createClient();

  Future destroyClient() async => await _bleManager.destroyClient();
}