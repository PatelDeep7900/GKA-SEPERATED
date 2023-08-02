import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:gka/components/common/custom_input_field.dart';
import 'package:gka/components/common/page_header.dart';
import 'package:gka/components/common/welcomepage1.dart';
import 'package:gka/components/forget_password_page.dart';
import 'package:gka/components/mainwelcome.dart';
import 'package:gka/components/signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:gka/components/common/page_heading.dart';

import 'package:gka/components/common/custom_form_button.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final _loginFormKey = GlobalKey<FormState>();
  String Emailval="";
  String Passval="";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xd9fd6d0c),
          body: Column(
            children: [
              const PageHeader(),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          const PageHeading(title: 'Log-in',),
                          CustomInputField(
                            onChanged: (value){
                               Emailval=value!;
                            },
                            labelText: 'Email',
                            hintText: 'Your email id',
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if(!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },

                          ),


                          const SizedBox(height: 16,),
                          CustomInputField(
                            onChanged: (value){
                              Passval=value!;
                            },
                            labelText: 'Password',
                            hintText: 'Your password',
                            obscureText: true,
                            suffixIcon: true,
                            validator: (textValue) {
                              if(textValue == null || textValue.isEmpty) {
                                return 'Password is required!';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16,),
                          Container(
                            width: size.width * 0.80,
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgetPasswordPage()))
                              },
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          CustomFormButton(innerText: 'Login', onPressed: _handleLoginUser,),
                          const SizedBox(height: 18,),
                          SizedBox(
                            width: size.width * 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account ? ', style: TextStyle(fontSize: 13, color: Color(0xff939393), fontWeight: FontWeight.bold),),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()))
                                  },
                                  child: const Text('Sign-up', style: TextStyle(fontSize: 15, color: Colors.blueAccent, fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }


  Future<void> loginapi(String Emailval,String Passval)async{
    const url="http://e-gam.com/GKARESTAPI/login";


    Response response=await post(
        Uri.parse(url),
        body:
        {
          'userEmail':Emailval,
          'userPass':Passval
        }
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(response.statusCode==200) {
      var data=jsonDecode(response.body.toString());
      print(data);
      var cond=data['result'];
      if(cond==true) {


        await prefs.setInt('id', data['id']);
        await prefs.setBool("result", true);
        await prefs.setString("user_Email", data['G_username']);
        await prefs.setString("User_Typ", data['User_Typ']);
        await prefs.setString("Name", data['Name']);

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainwelcome()));


      }else{
        await prefs.setBool("result", false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid UserName Or Password")),
        );
      }
    }else{
      await prefs.setBool("result", false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Server Not Responding")),
      );
    }




    }

  void _handleLoginUser() {

    if (_loginFormKey.currentState!.validate()) {
      loginapi(Emailval, Passval);
   }
  }
}
