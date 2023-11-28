
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gka/Screens/Login/components/login_form.dart';
import 'package:gka/Screens/Welcome/welcome_screen.dart';
import 'package:gka/components/mainwelcome.dart';
import 'package:gka/main.dart';
import 'package:gka/widgets/navigator.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void biomatriccheck()  async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    await Future.delayed(Duration(seconds: 3), () {
      if(id>0){
        if (!mounted) return;
        NavigationPushreplace(context,mainwelcome());
      }else{
        NavigationPushreplace(context,WelcomeScreen());
      }
    });
  }

  @override
  void initState() {
    biomatriccheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
