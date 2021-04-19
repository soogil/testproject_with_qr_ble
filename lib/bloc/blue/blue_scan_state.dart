import 'package:flutter/foundation.dart';
import 'package:testproject_with_qr_ble/model/bluetooth_model.dart';

enum BlueScanState {
  scanning,
  stop
}

abstract class BluetoothScanBlocState {
  BluetoothScanBlocState({
    List<BluetoothModel> deviceList,
    BlueScanState bluetoothScanState
  }) : this.deviceList = deviceList ?? [],
        this.bluetoothScanState = bluetoothScanState ?? BlueScanState.stop;

  final List<BluetoothModel> deviceList;
  final BlueScanState bluetoothScanState;

  String get scanText => this.bluetoothScanState == BlueScanState.scanning ? '중지' : ' 찾기';

  String get notificationText => '';
}

class InitBluetoothScanState extends BluetoothScanBlocState {
  InitBluetoothScanState({List<BluetoothModel> deviceList, BlueScanState bluetoothScanState})
      : super(deviceList: deviceList, bluetoothScanState: bluetoothScanState);
}
class UseLocationServiceState extends BluetoothScanBlocState {
  UseLocationServiceState({@required List<BluetoothModel> deviceList, @required BlueScanState bluetoothScanState})
      : super(deviceList: deviceList, bluetoothScanState: bluetoothScanState);

  @override
  String get notificationText => '위치정보를 활성화해야 블루투스 스캔이 가능합니다.';
}

class UseBluetoothServiceState extends BluetoothScanBlocState {
  UseBluetoothServiceState({@required List<BluetoothModel> deviceList, @required BlueScanState bluetoothScanState})
      : super(deviceList: deviceList, bluetoothScanState: bluetoothScanState);

  @override
  String get notificationText => '블루투스를 활성화해야 블루투스 스캔이 가능합니다.';
}