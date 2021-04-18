import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_bloc.dart';
import 'package:testproject_with_qr_ble/bloc/qr/qr_state.dart';

class QRScreenPage extends StatefulWidget {

  @override
  _QRScreenPageState createState() => _QRScreenPageState();
}

class _QRScreenPageState extends State<QRScreenPage> {

  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  QRBloc _qrBloc;

  @override
  void initState() {
    _qrBloc = BlocProvider.of<QRBloc>(context);
    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _qrBloc.pauseCamera();
    }
    _qrBloc.resumeCamera();
  }

  @override
  void dispose() {
    _qrBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildQrView(context),
        _resultView(),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return Expanded(
      flex: 4,
      child: QRView(
        key: _qrKey,
        onQRViewCreated: (controller) {
          _qrBloc.controller = controller;
        },
        overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea
        ),
      ),
    );
  }

  Widget _resultView() {
    return BlocBuilder<QRBloc, QRState>(
        builder: (context, state) {
          return Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.resultText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            _qrBloc.pauseCamera();
                          },
                          child: Text('camera stop', style: TextStyle(fontSize: 15)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            _qrBloc.resumeCamera();
                          },
                          child: Text('camera resume', style: TextStyle(fontSize: 15)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
    });
  }
}