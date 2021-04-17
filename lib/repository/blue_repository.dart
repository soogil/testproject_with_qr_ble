import 'dart:async';
import 'dart:io';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testproject_with_qr_ble/service/blue_enable_service.dart';

const int searchBluetoothDuration = 20000;

class BluetoothRepository {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  StreamSubscription _bluetoothScanSubscription;

  Future _checkPermissions() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> permissionStatus = await [
        Permission.location,
      ].request();

      final state = permissionStatus[Permission.location];
      print('_checkPermissions $state');

      return await Permission.location.request().isGranted;
    }
  }

  dispose() {
    _bluetoothScanSubscription.cancel();
  }
  
  Stream get bluetoothStateSubscription => BluetoothEnableService.instance.bluetoothStateStream;

  Future stopScan() async => await _bluetoothScanSubscription.cancel().then((value) => _flutterBlue.stopScan());

  Future startScan() => _checkPermissions().then((isGranted) => _bluetoothScanSubscription =
      _flutterBlue.scan(timeout: Duration(milliseconds: 20000)).listen((event) { }));

  StreamSubscription get bluetoothScanSubscription => _bluetoothScanSubscription;
}