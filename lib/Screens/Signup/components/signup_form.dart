import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

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
                Row(
                 children: [
                   Text(
                    'I have read and accept',
                    overflow: TextOverflow.ellipsis,
                    ),
                   TextButton(onPressed: () {
                     _showdialog();

                   }, child: Text("terms and conditions"))
                 ],
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

    String url='http://192.168.10.141:8084/GKARESTAPI/c_signup';
    final  response=await http.post(
        Uri.parse(url),
        body:
        {
          'email': _email.text,
          'fullname':_name.text,
        }
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      if(data['mailexists']==true){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('you can login')));
        if(data['result']==false){
          setState(() {
            isLoading=true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('data saveed!')));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('data not saveed!')));
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('This email is not exist!')));
      }
      print(data);
    }
  }
}