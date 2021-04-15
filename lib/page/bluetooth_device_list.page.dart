import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/blue_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/blue_event.dart';
import 'package:testproject_with_qr_ble/bloc/ble/blue_state.dart';
import 'package:testproject_with_qr_ble/model/BleModel.dart';


class BluetoothDeviceListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _buildBody(context),
    );
  }

  Widget _appbar() => AppBar(
    title: Text(
      'AppBar',
    ),
    actions: [
      _circleProgress(),
      _findBleButton(),
    ],
  );

  Widget _circleProgress() {
    return BlocBuilder<BlueBloc, BlueBlocState>(builder: (context, state) {
      return state.bluetoothScanState == BlueScanState.start ? Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.white,
        ),
      ) : Container();
    });
  }

  Widget _findBleButton() {
    return BlocBuilder<BlueBloc, BlueBlocState>(
      builder: (context, state) {
        final text = state.bluetoothScanState == BlueScanState.start ? '중지' : ' 찾기';
        return TextButton(
            onPressed: () {
              BlocProvider.of<BlueBloc>(context).add(StartBlueEvent());
              // _bleBloc.add(StartBlueEvent());
            },
            child: Text(
                text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<BlueBloc, BlueBlocState>(
        builder: (context, state) {
          print('_buildBody $state');
          return _buildBleList(state.deviceList);
        }
    );
  }

  Widget _buildBleList(List<BluetoothModel> bleList) {
    return ListView.builder(
      itemCount: bleList.length,
        itemBuilder: (context, index) {
        return _deviceListItem(bleList[index]);
        },
    );
  }

  Widget _deviceListItem(BluetoothModel bleModel) {
    return Container(
        height: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${bleModel.rssi} ${bleModel.deviceName}'
                  ),
                  Text(
                      '${bleModel.id} '
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Connect')
              )
            ],
          ),
        )
    );
  }
}
