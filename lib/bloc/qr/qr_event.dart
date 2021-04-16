import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

abstract class QREvent extends Equatable {
  @override
  List<Object> get props => [];
}
class InitQRScreenEvent extends QREvent {}
class SendResultQREvent extends QREvent {
  SendResultQREvent(this.result);

  final Barcode result;

  @override
  List<Object> get props => [result];
}