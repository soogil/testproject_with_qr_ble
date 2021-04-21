import 'package:flutter/material.dart';

abstract class BlueEnableBlocState {
  BlueEnableBlocState({@required isBluetoothEnabled})
      : this.isBluetoothEnabled = isBluetoothEnabled ?? true;

  bool isBluetoothEnabled;
}
class UseBluetoothState extends BlueEnableBlocState {
  UseBluetoothState({bool? isBluetoothEnabled}) : super(isBluetoothEnabled: isBluetoothEnabled);
}