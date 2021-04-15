import 'dart:async';
import 'dart:io';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

const int searchBluetoothDuration = 20000;

class BleRepository {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  final StreamController _bluetoothController = StreamController();
  final StreamController _bluetoothStateController = StreamController();
  StreamSubscription _subscription;

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
    _bluetoothController.close();
    _bluetoothStateController.close();
  }

  Future stopScan() async => await _subscription.cancel().then((value) => _flutterBlue.stopScan());

  Future startScan() => _checkPermissions().then((isGranted) => _subscription =
      _flutterBlue.scan(timeout: Duration(milliseconds: 20000)).listen((event) { }));

  Future bluetoothState() async => _flutterBlue.state.listen((event) {  // 블루투스 on off 체크
    _bluetoothStateController.add(event);
  });
  
  StreamSubscription get bluetoothSubscription => _subscription;
}