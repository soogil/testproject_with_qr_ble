import 'package:testproject_with_qr_ble/model/ble_model.dart';

abstract class BleScanBlocEvent{
  const BleScanBlocEvent();
}

class InitBleScanEvent extends BleScanBlocEvent {}
class ScanBleEvent extends BleScanBlocEvent {}
class FindDeviceEvent extends BleScanBlocEvent {
  const FindDeviceEvent(this.bleModel);

  final BleModel bleModel;
}
class BleEnableEvent extends BleScanBlocEvent {}