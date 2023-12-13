import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'forgotpasssetnew.dart';


class forgototppass extends StatefulWidget {
  const forgototppass({Key? key}) : super(key: key);

  @override
  State<forgototppass> createState() => _forgototppass();
}

class _forgototppass extends State<forgototppass> {

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
    String? _email=prefs.getString("G_username");
    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_forgotpass';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'cond':'resendotp',
            'G_username': _email,
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        invalidOtp = false;
        resendTime = 60;
        startTimer();
        bool checkmail = data['checkmail'];
        bool result = data['result'];

        if(checkmail==true && result==true) {
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please Check Your   Email')));
        }else{
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed To Send Verification Code Retry..')));
        }
      }else{
        invalidOtp = false;
        resendTime = 60;
        startTimer();
      }
    }on Exception catch (e) {
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server not Responding')));
      rethrow;
    }
  }


  void varificationotp()async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _email=prefs.getString("G_username");
    String? _fullname=prefs.getString("Name");

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_forgotpass';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'G_username': _email,
            'fullname': _fullname,
            'otp':_otp,
            'cond':'optcheck'
          }

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);


        if(data['optmatch']==true){
          stopTimer();
          setState(() {
            invalidOtp =false;
          });
          if(!mounted)return;
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => forgotpasssetnew()));

        }else{
          setState(() {
            invalidOtp =true;
          });
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Otp not matched')));
        }

      }
    }on Exception catch (e) {
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server not Responding')));
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
        title: const Text('OTP Verification(Forgot Password)'),
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
                  'Enter the Otp verification code received',
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Verify',
                    style: TextStyle(fontSize: 20),
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