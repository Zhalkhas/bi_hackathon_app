import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class BarcodeScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: QrCamera(
        qrCodeCallback: (String value) {
          print(value);
        },
      ),
    );
  }
}
