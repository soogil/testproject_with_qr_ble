import 'package:testproject_with_qr_ble/model/BleModel.dart';

enum BlueScanState {
  start,
  stop
}

abstract class BlueBlocState {
  BlueBlocState({
    List<BluetoothModel> deviceList,
    this.bluetoothScanState = BlueScanState.stop
  }) : this.deviceList = deviceList ?? [];

  final List<BluetoothModel> deviceList;
  final BlueScanState bluetoothScanState;
}

class InitBleState extends BlueBlocState {
  InitBleState({List<BluetoothModel> deviceList, BlueScanState state}) : super(deviceList: deviceList, bluetoothScanState: state);
}