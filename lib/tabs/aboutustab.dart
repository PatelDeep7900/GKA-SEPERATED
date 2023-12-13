import 'package:flutter/material.dart';
import '../widgets/AboutUswgt/Conventionhistory.dart';
import '../widgets/footer.dart';
import '../widgets/AboutUswgt/gkahistory.dart';
import '../widgets/AboutUswgt/visionmission.dart';

class aboutustab extends StatefulWidget {
  const aboutustab({super.key});

  @override
  State<aboutustab> createState() => _aboutustabState();
}

class _aboutustabState extends State<aboutustab> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Padding(
          padding: EdgeInsets.all(5.0),
          child: Center(child: Text('About Us',style: TextStyle(color: Color(0xFFF5951B),fontSize: 22),)),
        ),
        const SizedBox(height: 5,),
        const gkahistory(),
        const SizedBox(height: 10,),
        const conventionhistory(),
        const SizedBox(height: 10,),
        const visionmission(),
        const SizedBox(height: 10,),
        footer(),
      ],
    );
  }

}
