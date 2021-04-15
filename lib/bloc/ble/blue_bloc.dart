import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/blue_event.dart';
import 'package:testproject_with_qr_ble/bloc/ble/blue_state.dart';
import 'package:testproject_with_qr_ble/model/BleModel.dart';
import 'package:testproject_with_qr_ble/repository/blue_repository.dart';

class BlueBloc extends Bloc<BlueBlocEvent, BlueBlocState> {
  BlueBloc() : super(InitBleState());

  final BleRepository _bleRepository = BleRepository();

  @override
  Stream<BlueBlocState> mapEventToState(BlueBlocEvent event) async* {
    print('mapEventToState $event');

    if (event is InitBleEvent) {
      yield InitBleState();
    } else if(event is StartBlueEvent) {
      BlueScanState scanState;
      if(state.bluetoothScanState == BlueScanState.start) {
        scanState = BlueScanState.stop;
        _bluetoothScanStop();
      } else {
        scanState = BlueScanState.start;
        _bluetoothScanStart();
      }
      yield InitBleState(deviceList: state.deviceList, state: scanState);
    } else if (event is FindDeviceEvent) {
      state.deviceList.add(event.bleModel);
      print('FindDeviceEvent ${state.deviceList.length}');
      yield InitBleState(deviceList: state.deviceList, state: BlueScanState.start);
    }
  }
  
  void _bluetoothScanStart() {
    _bleRepository.startScan().then((value) {
      _bleRepository.bluetoothSubscription.onData((scanResult) {
        final BluetoothModel blueModel = BluetoothModel(scanResult);

        if (scanResult.advertisementData.localName != null &&
            !state.deviceList.contains(blueModel)) { // 일단 id 같으면 추가 안하도록
          this.add(FindDeviceEvent(blueModel));
        }
      });
      _bleRepository.bluetoothSubscription.onDone(() => this.add(StartBlueEvent()));
    }
    );
  }

  void _bluetoothScanStop() => _bleRepository.stopScan();

  _connectedDevice(BluetoothModel bluetoothModel) {

  }
}