import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gka/components/login_page.dart';
import 'package:gka/components/mainwelcome.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var a = prefs.getInt("id");
    if(a != null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainwelcome()));
    } else {
//Navigate to another screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

    }





  }

  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      checkingTheSavedData();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/images/wc.gif'),
      ),
    );
  }
}

// Replace this widget with your main application screen.
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GKA'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
