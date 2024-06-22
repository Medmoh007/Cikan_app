/* import 'package:cikan/pages/home.dart';
import 'package:cikan/pages/login.dart';
import 'package:cikan/pages/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: ChatterHome(),
    //home: ChatterLogin(),
    //home: ChatterSignUp(),
  ));
}

 *//*
import 'package:flutter/material.dart';
import 'pages/chatterScreen.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChatterScreen(),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cikan/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB6-fdVosJJnLuXTqLqJisj4Ej7az1tMak",
      authDomain: "chatapp-d6a60.firebaseapp.com",
      projectId: "chatapp-d6a60",
      storageBucket: "chatapp-d6a60.appspot.com",
      messagingSenderId: "827702266636",
      appId: "1:827702266636:web:744fdab54c718342b21729",
      measurementId: "G-24KX4C2B76",
    ),
  );
  runApp(MaterialApp(
    home: ChatterHome(),
  ));
}
