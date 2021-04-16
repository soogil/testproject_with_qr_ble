import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_event.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_state.dart';


class QRBloc extends Bloc<QREvent, QRState> {
  QRBloc() : super(InitQrScreenState(null));

  QRViewController _qrViewController;

  @override
  Stream<QRState> mapEventToState(QREvent event) async* {
    if (event is InitQRScreenEvent) {
      yield InitQrScreenState(null);
    } else if(event is SendResultQREvent) {
      yield ReceiveQRState(result: event.result);
    }
  }

  void pauseCamera() async => await _qrViewController.pauseCamera();

  void resumeCamera() async  => await _qrViewController.resumeCamera();

  void dispose() => _qrViewController?.dispose();

  set controller(QRViewController controller) {
    _qrViewController = controller;
    this.add(InitQRScreenEvent());

    _qrViewController.scannedDataStream.listen((result) {
      this.add(SendResultQREvent(result));
    });
  }

  QRViewController get controller => _qrViewController;
}