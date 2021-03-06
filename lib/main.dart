import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/ble/ble_scan_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/scan/blue_scan_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/enable/blue_enable_bloc.dart';
import 'package:testproject_with_qr_ble/page/bluetooth_device_list.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => BluetoothScanBloc()),
            BlocProvider(create: (_) => BleScanBloc()),
            BlocProvider(create: (_) => BlueEnableBloc())
          ],
          child: BluetoothDeviceListPage()
      ),
    );
  }
}
