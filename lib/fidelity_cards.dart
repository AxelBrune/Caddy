import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_widget/barcode_widget.dart';

// class FidelityCards extends StatelessWidget {
//   const FidelityCards({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class FidelityCards extends StatefulWidget {
  const FidelityCards({Key? key}) : super(key: key);

  @override
  _FidelityCardsState createState() => _FidelityCardsState();
}

class _FidelityCardsState extends State<FidelityCards> {
  String _scannedCode = 'Inconnu';
  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarCode() async {
    String result;
    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", 'Annuler', true, ScanMode.BARCODE);
    } on PlatformException {
      result = 'Problème de plateforme';
    }
    setState(() {
      _scannedCode = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => scanBarCode(),
          child: Text('Scanner'),
        ),
        Container(
          child: _scannedCode != 'Inconnu'
              ? BarcodeWidget(
                  color: Colors.white,
                  data: _scannedCode,
                  barcode: Barcode.ean13(drawEndChar: true),
                )
              : Text(
                  _scannedCode,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
        )
      ],
    );
  }
}
