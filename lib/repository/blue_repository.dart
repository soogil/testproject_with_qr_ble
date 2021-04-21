import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';

const int searchDuration = 2000;

class BluetoothRepository {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  dispose() => stopScan();
  
  Future stopScan() => _flutterBlue.stopScan();

  Stream<ScanResult> startScan() => _flutterBlue.scan(timeout: Duration(milliseconds: searchDuration));
}