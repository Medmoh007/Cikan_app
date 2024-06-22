import 'package:flutter/material.dart';
import 'package:cikan/pages/login.dart'; 
import 'package:cikan/pages/register.dart'; 

class ChatterHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'heroicon',
                  child: Icon(
                    Icons.textsms,
                    size: 100,
                    color: Color.fromARGB(255, 159, 35, 128),
                  ),
                ),
                SizedBox(height: 20),
                Hero(
                  tag: 'HeroTitle',
                  child: Text(
                    'Cikan',
                    style: TextStyle(
                      color: Color.fromARGB(255, 159, 35, 128),
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                 SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "L'application développée par Traoré Mahamadou & Sika Ange Mobio".toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatterLogin()),
                    );
                  },
                  child: Text('Connexion'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatterSignUp()),
                    );
                  },
                  child: Text('Inscription'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
