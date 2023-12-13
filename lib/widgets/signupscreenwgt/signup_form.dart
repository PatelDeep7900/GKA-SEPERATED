import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../homepage.dart';
import '../../screens/Loginscreen/login_screen.dart';
import '../../screens/signupscreen/already_have_an_account_acheck.dart';
import '../../screens/signupscreen/otp_page.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _globkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  TextStyle defaultStyle = const TextStyle(color: Colors.grey, fontSize: 15.0);
  TextStyle linkStyle = const TextStyle(color: Colors.blue);
  bool agree = false;
  bool isLoading=false;

  void _handleSignup() {
    if (_globkey.currentState!.validate()) {
      _doSomething();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _globkey,
        child: Column(
          children: [
            TextFormField(
              controller: _name,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9 a-zA-Z]")),
              ], //
              maxLength: 30,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              validator: (val){
                if(val!.isEmpty){
                  return 'Please enter Full Name';
                }
              },
              decoration: const InputDecoration(
                counterText: "",
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              maxLength: 80,
              onSaved: (email) {},
              validator: (val){
                 if(val!.isEmpty){
                   return 'Please enter Email';
                 }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                     .hasMatch(val))
                 {
                 return 'Please enter valid email';
                 }
              },
              decoration: const InputDecoration(
                counterText: "",
                hintText: "Your email",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
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
                        const TextSpan(text: 'I have read and accept '),
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
              onPressed: agree ? _handleSignup : null,
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

            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "More about GKA | ",
                  style: TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Click Here",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showdialog(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 320,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text("[GKA APP]", style: TextStyle( fontSize: 20.0,fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 15.0),
                        children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(color: Colors.black54),
                            text: 'You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised. Privacy Policy is posted. This Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party. This privacy policy was created using Termly.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
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
      String url = 'http://e-gam.com/GKARESTAPI/c_signup';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'email': _email.text.toString(),
            'fullname': _name.text.toString(),
          }
      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
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
              await prefs.setString('email', _email.text);
              await prefs.setString('fullname', _name.text);
              if(!mounted)return;
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPPage(),));
            }else{
              if(!mounted)return;
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('retry')));
            }
          }else {
            if(!mounted)return;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed To Register')));
          }

        }
        setState(() {
          isLoading = false;
        });

      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Server not Responding')));

      setState(() {
        isLoading = false;
      });
      print('error caught: $e');
      rethrow;
    }

  }

}