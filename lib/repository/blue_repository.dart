import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

const int searchDuration = 2000;

class BluetoothRepository {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  StreamSubscription _bluetoothScanSubscription;

  dispose() => stopScan();
  
  Future stopScan() async => await _bluetoothScanSubscription.cancel().then((value) => _flutterBlue.stopScan());

  Stream<ScanResult> startScan() => _flutterBlue.scan(timeout: Duration(milliseconds: searchDuration));

  StreamSubscription get bluetoothScanSubscription => _bluetoothScanSubscription;
}