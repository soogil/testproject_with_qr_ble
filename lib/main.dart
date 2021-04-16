import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/blue/blue_bloc.dart';
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
            BlocProvider(create: (_) => BlueBloc()),
            BlocProvider(create: (_) => BlueEnableBloc())
          ],
          child: BluetoothDeviceListPage()
      ),
    );
  }
}
