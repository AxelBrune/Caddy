import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:caddy/fidelity_edition.dart';

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FidelityEdition(
            barcode: result,
          ),
        ),
      );
    } on PlatformException {
      result = 'Problème de plateforme';
    }
    // setState(() {
    //   _scannedCode = result;
    // });
  }

  final Stream<QuerySnapshot> _cardsStream =
      FirebaseFirestore.instance.collection('fidelityCards').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _cardsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Scaffold(
            backgroundColor: Colors.blueGrey.shade800,
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0),
              elevation: 0,
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () => scanBarCode())
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    speed: 1000,
                    front: Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['shop'],
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    back: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BarcodeWidget(
                            color: Colors.black,
                            data: data['barcode'],
                            barcode: Barcode.ean13(drawEndChar: true),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),
            ),
          );
        });
  }
}
