
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../homepage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:  Center(
        child: AnimatedSplashScreen(
          splashIconSize: 150,
          duration: 15,
          backgroundColor: Colors.black,
          splash: Column(
            children: [
              Expanded(child: Image.asset('assets/images/logo.png')),
              const Text
                ("G K A ",
                style: TextStyle(fontSize: 20,color: Colors.white),
              ),
              const SizedBox(height: 10,),
              const Text
                ("Gujarati Kshatriya Association USA & Canada ",
                  style: TextStyle(fontSize: 12,color: Colors.white),
              ),
            ],
          ),
          nextScreen: const HomePage(),
          splashTransition: SplashTransition.fadeTransition,
        ),
      ),
    );
  }
}
