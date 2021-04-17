import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_state.dart';
import 'package:testproject_with_qr_ble/service/blue_enable_service.dart';

class BlueEnableBloc extends Bloc<BlueEnableBlocEvent, BlueEnableBlocState> {
  BlueEnableBloc() : super(UseBluetoothState()) {
    _bluetoothStateSubscription = _blueService.bluetoothStateStream.listen((result) =>
        this.add(ChangeBluetoothStateEvent(result))
    );
    _blueService.isBluetoothEnabled.then((value) => this.add(InitBluetoothEnableEvent(value)));
  }

  final BluetoothEnableService _blueService = BluetoothEnableService.instance;

  StreamSubscription _bluetoothStateSubscription;

  @override
  Stream<BlueEnableBlocState> mapEventToState(BlueEnableBlocEvent event) async* {
    if (event is UseBluetoothEvent) {
      await _blueService.changeBluetoothState;
      final bool isBluetoothEnabled = await _blueService.isBluetoothEnabled;
      yield UseBluetoothState(isBluetoothEnabled: isBluetoothEnabled);
    } else if (event is ChangeBluetoothStateEvent) {
      yield UseBluetoothState(isBluetoothEnabled: event.isBluetoothEnabled);
    } else if (event is InitBluetoothEnableEvent) {
      yield UseBluetoothState(isBluetoothEnabled: event.isBluetoothEnabled);
    }
  }

  dispose() {
    _bluetoothStateSubscription.cancel();
  }
}