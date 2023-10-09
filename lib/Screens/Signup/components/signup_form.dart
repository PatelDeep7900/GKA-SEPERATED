import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gka/Screens/Signup/signupotp.dart';
import 'package:http/http.dart' as http;

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import '../verification_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool agree = false;
  bool isLoading=false;
   final TextEditingController _email = TextEditingController();
   final TextEditingController _name = TextEditingController();

  TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 15.0);
  TextStyle linkStyle = TextStyle(color: Colors.blue);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: _name,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your Full Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 1),

          TextFormField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding / 1),
          Row(
            children: [
              Material(
                child: Checkbox(
                  value: agree,
                  onChanged: (value) {
                 setState(() {
                   agree=value!;
                 });
                  },
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: defaultStyle,
                    children: <TextSpan>[
                      TextSpan(text: 'I have read and accept '),
                      TextSpan(
                          text: 'terms and conditions',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              _showdialog();
                            }),

                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: defaultPadding),


          ElevatedButton(

            onPressed: agree ? _doSomething : null,
            child: isLoading? const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Loading...', style: TextStyle(fontSize: 20),),
                SizedBox(width: 10,),
                CircularProgressIndicator(color: Colors.white,),
              ],
            ) :  Text('Sign Up'.toUpperCase()),
          ),

          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
            },
            child: Text("mail".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );




  }

  void _showdialog(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.orangeAccent,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("[GKA APP]", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised. Privacy Policy is posted. This Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party. This privacy policy was created using Termly.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    child: const Text('Close'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

  }


  Future<void>_doSomething() async{

    setState(() {
      isLoading=true;
    });

    try {
      String url = 'http://192.168.10.141:8084/GKARESTAPI/c_signup';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'email': _email.text.toString(),
            'fullname': _name.text.toString(),
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
              
              Navigator.push(context, MaterialPageRoute(builder: (context) => VerificationScreen2(),));
            }else{
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('retry')));
            }

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed To Register')));
          }

        }
        setState(() {
          isLoading = false;
        });

      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));

      setState(() {
        isLoading = false;
      });
      print('error caught: $e');
      rethrow;
    }

  }

}