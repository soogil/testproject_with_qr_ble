import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


abstract class QRState extends Equatable {
  QRState(this._result);

  final Barcode _result;

  String get resultText => _result != null
      ? 'Barcode Type: ${describeEnum(_result.format)}\nData: ${_result.code}'
      : 'Scan a code';

  @override
  List<Object> get props => [_result];
}
class InitQrScreenState extends QRState {
  InitQrScreenState(Barcode result) : super(result);
}
class ReceiveQRState extends QRState {
  ReceiveQRState({@required Barcode result}) : super(result);
}