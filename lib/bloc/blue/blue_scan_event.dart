import 'package:testproject_with_qr_ble/model/BluetoothModel.dart';

abstract class BluetoothScanBlocEvent{
  const BluetoothScanBlocEvent();
}

class InitBluetoothScanEvent extends BluetoothScanBlocEvent {}
class ScanBluetoothEvent extends BluetoothScanBlocEvent {}
class FindDeviceEvent extends BluetoothScanBlocEvent {
  const FindDeviceEvent(this.bleModel);

  final BluetoothModel bleModel;
}
class BluetoothEnableEvent extends BluetoothScanBlocEvent {}