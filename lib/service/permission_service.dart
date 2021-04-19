import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future checkPermissions() async {
    final permissionList = [
      Permission.location,
    ];

    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> permissionStatus = await permissionList.request();

      final states = permissionStatus.values.toList();
      final state = permissionStatus[Permission.location];
      print('_checkPermissions $state');
      print('_checkPermissions $states');

      bool isGranted = true;
      permissionList.forEach((element) async {
        isGranted ^= await element.request().isGranted;
      });

      return isGranted;
    }
  }
}