import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_event.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_state.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_state.dart';
import 'package:testproject_with_qr_ble/model/ble_model.dart';
import 'package:testproject_with_qr_ble/repository/ble_repository.dart';
import 'package:testproject_with_qr_ble/service/blue_enable_service.dart';


class BleScanBloc extends Bloc<BleScanBlocEvent, BleScanBlocState> {
  BleScanBloc() : super(InitBleScanState());

  final BleRepository _bleRepository = BleRepository();
  final BluetoothEnableService _bleService = BluetoothEnableService.instance;

  StreamSubscription? _bleScanSubscription;

  @override
  Stream<BleScanBlocState> mapEventToState(BleScanBlocEvent event) async* {
    if (event is InitBleScanEvent) {
      yield InitBleScanState();
    } else if(event is ScanBleEvent) {
      final isBluetoothEnabled = await _bleService.isBluetoothEnabled;
      final isLocationEnabled = await _bleService.isLocationEnabled;

      BlueScanState? bleScanState;

      if (isBluetoothEnabled) {
        if (isLocationEnabled) {
          if (state.bleScanState == BlueScanState.scanning) {
            bleScanState = _stopBluetoothScan();
          } else {
            bleScanState = _startBluetoothScan();
          }
          yield InitBleScanState(bleList: state.bleList, bleScanState: bleScanState);

        } else {
          yield UseBleLocationServiceState(bleList: state.bleList, bleScanState: bleScanState);
        }
      } else {
        yield UseBleServiceState(bleList: state.bleList, bleScanState: bleScanState);
      }
    } else if(event is BleEnableEvent) {
      var bleScanState;

      if (state.bleScanState == BlueScanState.scanning) {
        bleScanState = _stopBluetoothScan();
      }

      yield InitBleScanState(bleList: state.bleList, bleScanState: bleScanState);
    } else if (event is FindDeviceEvent) {
      state.bleList.add(event.bleModel);
      yield InitBleScanState(bleList: state.bleList, bleScanState: state.bleScanState);
    }
  }

  BlueScanState _startBluetoothScan() {
    _bleScanStart();
    return BlueScanState.scanning;
  }

  BlueScanState _stopBluetoothScan() {
    _bleScanSubscription?.cancel();
    return BlueScanState.stop;
  }

  //todo 30초 안에 5번 스캔 start 시 Unhandled Exception: BleError 발생 처리
  void _bleScanStart() {
    _bleScanSubscription = _bleRepository.startBleScan().listen((scanResult) {
      final BleModel blueModel = BleModel(scanResult);

      if (scanResult.advertisementData.localName != null
          && !state.bleList.contains(blueModel)) { // 일단 id 같으면 추가 안하도록
        this.add(FindDeviceEvent(blueModel));
      }
    }, onDone: () {
      this.add(ScanBleEvent());
    });
  }

  void dispose() => _bleRepository.dispose();
}
