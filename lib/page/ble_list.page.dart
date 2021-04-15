import 'package:flutter/material.dart';
import 'package:testproject_with_qr_ble/service/ble_service.dart';

class BleListPage extends StatefulWidget {
  @override
  _BleListPageState createState() => _BleListPageState();
}

class _BleListPageState extends State<BleListPage> {

  @override
  void initState() {
    BleService().createClient().then((value) {
      print('Ble createClient $value');
    });
    super.initState();
  }

  @override
  void dispose() {
    BleService().destroyClient().then((value) => print('Ble destroyClient $value'));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
