import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_state.dart';
import 'package:testproject_with_qr_ble/model/bluetooth_model.dart';
import 'package:testproject_with_qr_ble/repository/blue_repository.dart';
import 'package:testproject_with_qr_ble/service/blue_enable_service.dart';

class BluetoothScanBloc extends Bloc<BluetoothScanBlocEvent, BluetoothScanBlocState> {
  BluetoothScanBloc() : super(InitBluetoothScanState());

  final BluetoothRepository _blueRepo = BluetoothRepository();

  @override
  Stream<BluetoothScanBlocState> mapEventToState(BluetoothScanBlocEvent event) async* {
    if (event is InitBluetoothScanEvent) {
      yield InitBluetoothScanState();
    } else if(event is ScanBluetoothEvent) {
      final isBluetoothEnabled = await BluetoothEnableService.instance.isBluetoothEnabled;
      final isLocationEnabled = await BluetoothEnableService.instance.isLocationEnabled;

      var bluetoothScanState;

      if (isBluetoothEnabled) {
        if (isLocationEnabled) {
          if (state.bluetoothScanState == BlueScanState.scanning) {
            bluetoothScanState = _stopBluetoothScan();
          } else {
            bluetoothScanState = _startBluetoothScan();
          }
          yield InitBluetoothScanState(deviceList: state.deviceList, bluetoothScanState: bluetoothScanState);

        } else {
          yield UseLocationServiceState(deviceList: state.deviceList, bluetoothScanState: bluetoothScanState);
        }
      } else {
        yield UseBluetoothServiceState(deviceList: state.deviceList, bluetoothScanState: bluetoothScanState);
      }
    } else if(event is BluetoothEnableEvent) {
      var bluetoothScanState;

      if (state.bluetoothScanState == BlueScanState.scanning) {
        bluetoothScanState = _stopBluetoothScan();
      }

      yield InitBluetoothScanState(deviceList: state.deviceList, bluetoothScanState: bluetoothScanState);
    } else if (event is FindDeviceEvent) {
      state.deviceList.add(event.bleModel);
      yield InitBluetoothScanState(deviceList: state.deviceList, bluetoothScanState: state.bluetoothScanState);
    }
  }

  BlueScanState _startBluetoothScan() {
    _bluetoothScanStart();
    return BlueScanState.scanning;
  }

  BlueScanState _stopBluetoothScan() {
    _blueRepo.stopScan();
    return BlueScanState.stop;
  }
  
  void _bluetoothScanStart() {
    _blueRepo.startScan().listen((scanResult) {
      final BluetoothModel blueModel = BluetoothModel(scanResult);

      if (!state.deviceList.contains(blueModel)) { // ?????? id ????????? ?????? ????????????
        this.add(FindDeviceEvent(blueModel));
      }
    }, onDone: () => this.add(ScanBluetoothEvent()));
  }

  void dispose() => _blueRepo.dispose();
}