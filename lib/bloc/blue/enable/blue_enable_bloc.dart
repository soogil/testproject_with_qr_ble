import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_state.dart';
import 'package:testproject_with_qr_ble/service/blue_enable_service.dart';

class BlueEnableBloc extends Bloc<BlueEnableBlocEvent, BlueEnableBlocState> {

  BlueEnableBloc() : super(UseBluetoothState(BluetoothEnableService().isEnable));

  final BluetoothEnableService _blueService = BluetoothEnableService();

  @override
  Stream<BlueEnableBlocState> mapEventToState(BlueEnableBlocEvent event) async* {
    if (event is UseBluetoothEvent) {
      await _blueService.useBluetoothEnable;
      final bool isEnable = await _blueService.isEnabledBluetooth;
      yield UseBluetoothState(isEnable);
    }
  }
}