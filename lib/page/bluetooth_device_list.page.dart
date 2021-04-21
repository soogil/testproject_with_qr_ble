import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_event.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_state.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_state.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_event.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_state.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_bloc.dart';
import 'package:testproject_with_qr_ble/model/ble_model.dart';
import 'package:testproject_with_qr_ble/model/bluetooth_model.dart';
import 'package:testproject_with_qr_ble/page/qr_screen.page.dart';
import 'package:testproject_with_qr_ble/service/permission_service.dart';


class BluetoothDeviceListPage extends StatefulWidget {

  @override
  _BluetoothDeviceListPageState createState() => _BluetoothDeviceListPageState();
}

class _BluetoothDeviceListPageState extends State<BluetoothDeviceListPage> {

  BluetoothScanBloc? _scanBloc;
  BleScanBloc? _bleScanBloc;
  BlueEnableBloc? _blueEnableBloc;

  @override
  void initState() {
    // _scanBloc = BlocProvider.of<BluetoothScanBloc>(context);
    PermissionService().checkPermissions();
    _blueEnableBloc = BlocProvider.of<BlueEnableBloc>(context);
    _bleScanBloc = BlocProvider.of<BleScanBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _scanBloc?.dispose();
    _blueEnableBloc?.dispose();
    _bleScanBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) => AppBar(
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
    return BlocBuilder<BleScanBloc, BleScanBlocState>(builder: (context, state) {
      return state.bleScanState == BlueScanState.scanning ? Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          backgroundColor: Colors.white,
        ),
      ) : Container();
    });

    return BlocBuilder<BluetoothScanBloc, BluetoothScanBlocState>(
        builder: (context, state) {
          return state.bluetoothScanState == BlueScanState.scanning ? Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.white,
            ),
          ) : Container();
        });
  }

  Widget _findBleButton() {
    return BlocBuilder<BleScanBloc, BleScanBlocState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () {
              _bleScanBloc!.add(ScanBleEvent());
            },
            child: Text(
              state.scanText,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
        );
      },
    );

    return BlocBuilder<BluetoothScanBloc, BluetoothScanBlocState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () {
              _scanBloc!.add(ScanBluetoothEvent());
            },
            child: Text(
              state.scanText,
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
    return Column(
      children: [
        _bluetoothEnable(context),
        _buildBluetoothList(context)
      ],
    );
  }

  Widget _buildBluetoothList(BuildContext context) {
    return BlocBuilder<BleScanBloc, BleScanBlocState>(
        builder: (context, state) {
          if(state is UseLocationServiceState || state is UseBleServiceState) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.notificationText)));
            });
          }

          return Expanded(
            child: ListView.builder(
                itemCount: state.bleList.length,
                itemBuilder: (context, index) => _deviceListItem(state.bleList[index])
            ),
          );
        }
    );
    return BlocBuilder<BluetoothScanBloc, BluetoothScanBlocState>(
        builder: (context, state) {
          if(state is UseLocationServiceState || state is UseBluetoothServiceState) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.notificationText)));
            });
          }

          return Expanded(
            child: ListView.builder(
                itemCount: state.deviceList.length,
                itemBuilder: (context, index) => _deviceListItem2(state.deviceList[index])
            ),
          );
        }
    );
  }

  Widget _bluetoothEnable(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('bluetoothEnable'),
        BlocBuilder<BlueEnableBloc, BlueEnableBlocState>(
            builder: (context, state) {
              if(!state.isBluetoothEnabled) {
                print('bluetoothEnable ${state.isBluetoothEnabled}');
                // _scanBloc.add(BluetoothEnableEvent());
                _bleScanBloc!.add(BleEnableEvent());
              }

              return Switch(
                  value: state.isBluetoothEnabled,
                  onChanged: (toggle) =>
                      _blueEnableBloc!.add(UseBluetoothEvent())
              );}
        ),
      ]);
  }

  Widget _deviceListItem(BleModel bleModel) {
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
                      '${bleModel.id}'
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  // onPressed: () => bleModel.peripheral.connect(
                  //   timeout: Duration(milliseconds: 15000)
                  // ),
                  child: Text('Connect')
              )
            ],
          ),
        )
    );
  }

  Widget _deviceListItem2(BluetoothModel bleModel) {
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
                      '${bleModel.id}'
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {},
                  // onPressed: () => bleModel.peripheral.connect(
                  //   timeout: Duration(milliseconds: 15000)
                  // ),
                  child: Text('Connect')
              )
            ],
          ),
        )
    );
  }
}
