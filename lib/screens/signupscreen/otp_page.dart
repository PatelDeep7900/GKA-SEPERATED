import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gka/screens/signupscreen/passset.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {

  bool invalidOtp = false;
  int resendTime = 60;
  String? _otp;

  late Timer countdownTimer;
  TextEditingController txt1 = TextEditingController();
  TextEditingController txt2 = TextEditingController();
  TextEditingController txt3 = TextEditingController();
  TextEditingController txt4 = TextEditingController();

  @override
  void initState() {
    startTimer();
    super.initState();
  }


  Future<void> _resendotp() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _email=prefs.getString("email");
    String? _fullname=prefs.getString("fullname");
    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_signup';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'email': _email,
            'fullname': _fullname,
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        invalidOtp = false;
        resendTime = 60;
        startTimer();
        bool mailexists = data['mailexists'];
        if (mailexists) {
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('This Email Adress Already Exists...')));
        } else {
          bool result = data['result'];
          if (result == true) {
            bool checkmail=data['checkmail'];
            if(checkmail==true){
              if(!mounted)return;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('otp send')));

            }else{
              if(!mounted)return;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('retry')));
            }

          } else {
            if(!mounted)return;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed To Register')));
          }

        }

      }else{
        invalidOtp = false;
        resendTime = 60;
        startTimer();
      }



    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));
      rethrow;
    }
  }


  void varificationotp()async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _email=prefs.getString("email");
    String? _fullname=prefs.getString("fullname");
    print(_fullname);

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_verificationotp';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'email': _email,
            'fullname': _fullname,
            'otp':_otp
          }

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        bool otpcheck = data['otpcheck'];
        if(otpcheck==true){
          stopTimer();
          setState(() {
            invalidOtp =false;
          });
          if(!mounted)return;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => passwordset(),));


        }else{
          setState(() {
            invalidOtp =true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Otp not matched')));
        }




      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }




  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  String strFormatting(n) => n.toString().padLeft(2, '0');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 30),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter the 4 digit verification code received',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myInputBox(context, txt1),
                    myInputBox(context, txt2),
                    myInputBox(context, txt3),
                    myInputBox(context, txt4),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Haven't received OTP yet?",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    resendTime == 0
                        ? InkWell(
                      onTap: ()
                      {
                        _resendotp();
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    )
                        : const SizedBox()
                  ],
                ),
                const SizedBox(height: 10),
                resendTime != 0
                    ? Text(
                  'You can resend OTP after ${strFormatting(resendTime)} second(s)',
                  style: const TextStyle(fontSize: 18),
                )
                    : const SizedBox(),
                const SizedBox(height: 5),
                Text(
                  invalidOtp ? 'Invalid otp!' : '',
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                     setState(() {
                       _otp = txt1.text + txt2.text + txt3.text + txt4.text;
                     });
                     varificationotp();
                  },
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget myInputBox(BuildContext context, TextEditingController controller) {
  return Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      border: Border.all(width: 1),
      borderRadius: const BorderRadius.all(
        Radius.circular(60),
      ),
    ),
    child: TextField(
      controller: controller,
      maxLength: 1,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 24),
      decoration: const InputDecoration(
        counterText: '',
      ),
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
      },
    ),
  );
}