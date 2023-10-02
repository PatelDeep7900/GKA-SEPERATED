import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/mainwelcome.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';



class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {

    final _loginFormKey = GlobalKey<FormState>();
    TextEditingController _cemail=TextEditingController();
    TextEditingController _cpass=TextEditingController();

    void _handleLoginUser() {

      if (_loginFormKey.currentState!.validate()) {
        loginapi(_cemail.text, _cpass.text);
      }
    }

    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: _cemail,
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
            validator:(textValue) {
              if(textValue == null || textValue.isEmpty) {
                return 'Email is required!';
              }
              if(!EmailValidator.validate(textValue)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          Padding(

            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: _cpass,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),

              ),
              validator: (textValue) {
                if(textValue == null || textValue.isEmpty) {
                  return 'Password is required!';
                }
                return null;
              },

            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                _handleLoginUser();
              },
              child: const Text(
                "LOGIN",
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
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

      bool cimgpathexists1=data['cimgpathexists1'];
      bool cimgpathexists2=data['cimgpathexists2'];

      if(cond==true) {

        await prefs.setInt('id', data['id']);
        await prefs.setBool("result", true);
        await prefs.setString("user_Email", data['G_username']);
        await prefs.setString("User_Typ", data['User_Typ']);
        await prefs.setString("Name", data['Name']);
        if(cimgpathexists1==true){
          await prefs.setString("img1", data['img1']);
        }else{
          await prefs.setString("img1", "assets/images/nopic.png");
        }

        if(cimgpathexists2==true){
          await prefs.setString("img2", data['img2']);
        }else{
          await prefs.setString("img2", "assets/images/nopic.png");
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) => mainwelcome()));


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


}
