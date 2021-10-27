import 'package:flutter/material.dart';
import 'package:caddy/fidelity_cards.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  static const List<Widget> _widgetList = <Widget>[
    Text('Page 1', style: TextStyle(color: Colors.white)),
    FidelityCards(),
    Text('Page 3', style: TextStyle(color: Colors.white)),
  ];

  void _onItemPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: Colors.blueGrey.shade800,
  //     body: Center(
  //       child: _widgetList.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //       elevation: 0,
  //       backgroundColor: Colors.white.withOpacity(0),
  //       selectedItemColor: Colors.white,
  //       unselectedItemColor: Colors.grey,
  //       currentIndex: _selectedIndex,
  //       onTap: _onItemPressed,
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.home,
  //           ),
  //           label: "Accueil",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.credit_card_rounded,
  //           ),
  //           label: "Cartes",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(
  //             Icons.person,
  //           ),
  //           label: "Mon compte",
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return FlutterLogo();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: Colors.blueGrey.shade800,
            body: Center(
              child: _widgetList.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white.withOpacity(0),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              currentIndex: _selectedIndex,
              onTap: _onItemPressed,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.credit_card_rounded,
                  ),
                  label: "Cartes",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: "Mon compte",
                ),
              ],
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FlutterLogo();
      },
    );
  }
}
