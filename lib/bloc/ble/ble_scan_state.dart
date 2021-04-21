import 'package:flutter/foundation.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_state.dart';
import 'package:testproject_with_qr_ble/model/ble_model.dart';



abstract class BleScanBlocState {
  BleScanBlocState({
    List<BleModel>? bleList,
    BlueScanState? bleScanState
  }) : this.bleList = bleList ?? [],
        this.bleScanState = bleScanState ?? BlueScanState.stop;

  final List<BleModel> bleList;
  final BlueScanState bleScanState;

  String get scanText => this.bleScanState == BlueScanState.scanning ? '중지' : ' 찾기';

  String get notificationText => '';
}

class InitBleScanState extends BleScanBlocState {
  InitBleScanState({List<BleModel>? bleList, BlueScanState? bleScanState})
      : super(bleList: bleList, bleScanState: bleScanState);
}
class UseBleLocationServiceState extends BleScanBlocState {
  UseBleLocationServiceState({@required List<BleModel>? bleList, @required BlueScanState? bleScanState})
      : super(bleList: bleList, bleScanState: bleScanState);

  @override
  String get notificationText => '위치정보를 활성화해야 블루투스 스캔이 가능합니다.';
}

class UseBleServiceState extends BleScanBlocState {
  UseBleServiceState({@required List<BleModel>? bleList, @required BlueScanState? bleScanState})
      : super(bleList: bleList, bleScanState: bleScanState);

  @override
  String get notificationText => '블루투스를 활성화해야 블루투스 스캔이 가능합니다.';
}