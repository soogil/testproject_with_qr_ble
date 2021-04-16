import 'package:testproject_with_qr_ble/model/BleModel.dart';

abstract class BlueBlocEvent{
  const BlueBlocEvent();
}

class InitBleEvent extends BlueBlocEvent {}
class StartBlueEvent extends BlueBlocEvent {}
class StopBlueEvent extends BlueBlocEvent {}
class FindDeviceEvent extends BlueBlocEvent {
  const FindDeviceEvent(this.bleModel);

  final BluetoothModel bleModel;
}
class BluetoothEnableEvent extends BlueBlocEvent {}