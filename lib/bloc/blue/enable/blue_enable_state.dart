import 'package:flutter/material.dart';

abstract class BlueEnableBlocState {
  const BlueEnableBlocState({@required isBluetoothEnable})
      : this.isBluetoothEnable = isBluetoothEnable ?? true;

  final bool isBluetoothEnable;
}
class UseBluetoothState extends BlueEnableBlocState {
  UseBluetoothState(bool isBluetoothEnable) : super(isBluetoothEnable: isBluetoothEnable);
}