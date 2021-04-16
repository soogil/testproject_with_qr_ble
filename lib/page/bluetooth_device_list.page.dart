import 'package:bluetooth_plugin/bluetooth_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/blue_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/blue_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/blue_state.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_state.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_bloc.dart';
import 'package:testproject_with_qr_ble/model/BleModel.dart';
import 'package:testproject_with_qr_ble/page/qr_screen.page.dart';


class BluetoothDeviceListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _buildBody(context),
    );
  }

  Widget _appbar(BuildContext context) => AppBar(
    title: Text(
      'AppBar',
    ),
    actions: [
      _navigateQrView(context),
      _circleProgress(),
      _findBleButton(),
    ],
  );

  Widget _navigateQrView(BuildContext context) {
    return TextButton(
        onPressed: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) =>
                BlocProvider(create: (_) => QRBloc(), child: QRScreenPage(),)
            )),
        child: Text('QR스캔',
          style: TextStyle(
              fontSize: 15,
              color: Colors.white
          ),
        )
    );
  }

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
          return _buildBleList(context, state.deviceList);
        }
    );
  }

  Widget _buildBleList(BuildContext context, List<BluetoothModel> bleList) {
    return Column(
      children: [
        // _bluetoothEnable(context),
        Expanded(
          child: ListView.builder(
            itemCount: bleList.length,
              itemBuilder: (context, index) => _deviceListItem(bleList[index])
          ),
        ),
      ],
    );
  }

  Widget _bluetoothEnable(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('bluetoothEnable'),
        BlocBuilder<BlueEnableBloc, BlueEnableBlocState>(builder: (context, state) {
          print('BlueEnableBloc ${state.isBluetoothEnable}');
            return Switch(value: state.isBluetoothEnable, onChanged: (toggle) =>
                BluetoothPlugin.connectionStatus().listen((event) {
                  print('connectionStatus $event');
                })
                // BlocProvider.of<BlueEnableBloc>(context).add(UseBluetoothEvent())
            );}
        ),
      ],
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
