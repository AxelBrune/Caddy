import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';

class FidelityEdition extends StatefulWidget {
  final String barcode;
  final String shopName;

  const FidelityEdition(
      {Key? key, @required this.barcode = "", this.shopName = ""})
      : super(key: key);

  @override
  _FidelityEditionState createState() => _FidelityEditionState();
}

class _FidelityEditionState extends State<FidelityEdition> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  int selectedColor = Colors.teal.value;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  Future<void> addCard() {
    CollectionReference fidelityCards =
        FirebaseFirestore.instance.collection('fidelityCards');

    return fidelityCards.add({
      'barcode': widget.barcode,
      'shop': nameController.text,
      'color': selectedColor,
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) => print("Failed to add card: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text('Ajouter une carte de fidélité'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.blueGrey.shade800,
        child: Form(
          key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                // Container(
                //   color: Colors.white,
                //   child: BarcodeWidget(
                //     color: Colors.black,
                //     data: widget.barcode,
                //     barcode: Barcode.ean13(drawEndChar: true),
                //   ),
                // ),
                // const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Nom du magasin',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Merci d\'inscrire le nom du magasin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedColor = Colors.teal.value;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.teal,
                        child: selectedColor == Colors.teal.value
                            ? const Icon(
                                Icons.check,
                              )
                            : const Text(''),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), primary: Colors.teal),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedColor = Colors.purple.value;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.purple,
                        child: selectedColor == Colors.purple.value
                            ? const Icon(Icons.check)
                            : const Text(''),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.purple),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedColor = Colors.amber.value;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.amber,
                        child: selectedColor == Colors.amber.value
                            ? Icon(Icons.check)
                            : Text(''),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.amber),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedColor = Colors.blue.value;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.blue,
                        child: selectedColor == Colors.blue.value
                            ? Icon(Icons.check)
                            : Text(''),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.blue),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedColor = Colors.red.value;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        color: Colors.red,
                        child: selectedColor == Colors.red.value
                            ? Icon(Icons.check)
                            : Text(''),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: CircleBorder(), primary: Colors.red),
                    )
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addCard();
                      }
                    },
                    child: Text('Enregistrer la carte'),
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.green.shade800,
                      padding: const EdgeInsets.all(13),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
