import 'dart:async';
import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

const Color primaryColor = Color(0xFF121212);
const Color accentPurpleColor = Color(0xFF6A53A1);
const Color accentPinkColor = Color(0xFFF99BBD);
const Color accentDarkGreenColor = Color(0xFF115C49);
const Color accentYellowColor = Color(0xFFFFB612);
const Color accentOrangeColor = Color(0xFFEA7A3B);


class VerificationScreen2 extends StatefulWidget {
  @override
  _VerificationScreen2State createState() => _VerificationScreen2State();
}

class _VerificationScreen2State extends State<VerificationScreen2> {
  late List<TextStyle?> otpTextStyles;
  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue);
  OtpTimerButtonController controller = OtpTimerButtonController();
  String otp="";
  String email="";
  String name="";

  @override
  void initState() {
    super.initState();
  }

  Future<void>_doSomething() async{

    try {
      String url = 'http://192.168.10.141:8084/GKARESTAPI/c_signup';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'email': 'pdeep7900@gmail.com',
            'fullname': 'deep',
          }

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        bool mailexists = data['mailexists'];
        if (mailexists) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('This Email Adress Already Exists...')));
        } else {
          bool result = data['result'];
          if (result == true) {
            bool checkmail=data['checkmail'];
            if(checkmail==true){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('otp send')));
              controller.startTimer();

            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('retry')));
              controller.enableButton();
            }

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed To Register')));
            controller.enableButton();
          }

        }

      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));
      controller.enableButton();
      print('error caught: $e');
      rethrow;
    }

  }


  _requestOtp() async{
    controller.loading();
    Future.delayed(Duration(seconds: 2), () {
      _doSomething();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    otpTextStyles = [
      createStyle(accentPurpleColor),
      createStyle(accentYellowColor),
      createStyle(accentDarkGreenColor),
      createStyle(accentOrangeColor),
      createStyle(accentPinkColor),
      createStyle(accentPurpleColor),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text('OTP Verification'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification Code",
              style: theme.textTheme.headline4,
            ),
            SizedBox(height: 16),
            Text(
              "We texted you a code",
              style: theme.textTheme.headline6,
            ),


            Text("Please enter it below", style: theme.textTheme.headline6),
            Spacer(flex: 2),
            OtpTextField(
              numberOfFields: 6,
              borderColor: accentPurpleColor,
              focusedBorderColor: accentPurpleColor,
              styles: otpTextStyles,
              showFieldAsBox: false,
              fieldWidth: 45,
              borderWidth: 4.0,
              onCodeChanged: (String code) {
                setState(() {
                  otp=code;
                });
              },
              onSubmit: (String verificationCode) {
                setState(() {
                  otp=verificationCode;
                });
              }, // end onSubmit
            ),
            Spacer(flex: 3),
            CustomButton(
              onPressed: () {

              },
              title: "Confirm",
              color: primaryColor,
              textStyle: theme.textTheme.subtitle1?.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: OtpTimerButton(
                controller: controller,
                onPressed: () {
                  _requestOtp();
                },
                text: Text('Resend OTP'),
                duration: 5,
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.bodyMedium?.copyWith(color: color);
  }
}

// class Test extends StatelessWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             const SizedBox(height: 150),
//             // This my custom widget
//             const Text("Test Otp"),
//             const SizedBox(height: 20),
//             Container(
//               decoration: const BoxDecoration(color: Colors.transparent),
//               height: 100,
//               child: OtpTextField(
//                 fieldWidth: 60,
//                 borderWidth: 5,
//                 keyboardType: TextInputType.number,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 numberOfFields: 4,
//                 borderRadius: BorderRadius.circular(15),
//                 focusedBorderColor: primaryColor,
//                 styles: [
//                   createStyle(context, Colors.black),
//                   createStyle(context, Colors.black),
//                   createStyle(context, Colors.black),
//                   createStyle(context, Colors.black),
//                 ],
//                 autoFocus: true,
//                 //set to true to show as box or false to show as dash
//                 showFieldAsBox: true,
//                 //runs when a code is typed in
//                 onCodeChanged: (String code) {
//                   //handle validation or checks here
//                 },
//                 //runs when every textfield is filled
//                 onSubmit: (String verificationCode) {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: Text("Verification Code"),
//                           content: Text('Code entered is $verificationCode'),
//                         );
//                       });
//                 }, // end onSubmit
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   TextStyle? createStyle(BuildContext context, Color color) {
//     return Theme.of(context).textTheme.headline2!.copyWith(color: color);
//   }
// }

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.title,
    this.onPressed,
    this.height = 60,
    this.elevation = 1,
    this.color = primaryColor,
    this.textStyle,
  });

  final VoidCallback? onPressed;
  final double height;
  final double elevation;
  final String title;
  final Color color;

  // final BorderSide borderSide;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0)
        ),
      ),
      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textStyle,
          )
        ],
      ),
    );
  }



}