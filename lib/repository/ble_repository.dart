import 'dart:async';

import 'package:flutter_ble_lib/flutter_ble_lib.dart';

const int searchBluetoothDuration = 2000;

class BleRepository {
  BleRepository() {
    _bleManager.createClient(
        restoreStateIdentifier: 'restoreStateIdentifier',
        restoreStateAction: (peripherals) {
          peripherals.forEach((element) {
            print('createClient $element');
          });
        }
    );
  }

  final BleManager _bleManager = BleManager();

  Stream<ScanResult> startBleScan() =>
      _bleManager.startPeripheralScan(timeout: Duration(milliseconds: searchBluetoothDuration));

  Future stopBleScan() async => await _bleManager.stopPeripheralScan();

  dispose() => _bleManager.destroyClient();
}