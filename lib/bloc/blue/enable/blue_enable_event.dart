
abstract class BlueEnableBlocEvent{
  const BlueEnableBlocEvent();
}


class UseBluetoothEvent extends BlueEnableBlocEvent {}
class InitBluetoothEnableEvent extends BlueEnableBlocEvent {
  InitBluetoothEnableEvent(this.isBluetoothEnabled);

  final bool isBluetoothEnabled;
}
class ChangeBluetoothStateEvent extends BlueEnableBlocEvent {
  ChangeBluetoothStateEvent(this._isBluetoothEnabled);

  static const int _bluetoothStateOn = 12;
  final int _isBluetoothEnabled;

  bool get isBluetoothEnabled => _isBluetoothEnabled == _bluetoothStateOn;
}