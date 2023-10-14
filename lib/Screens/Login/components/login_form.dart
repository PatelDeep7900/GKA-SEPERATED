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
  bool _obtxt1=true;
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _cemail=TextEditingController();
  TextEditingController _cpass=TextEditingController();

  void _handleLoginUser() {

    if (_loginFormKey.currentState!.validate()) {
      loginapi(_cemail.text, _cpass.text);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 50, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormField(

              controller: _cemail,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              onSaved: (email) {},
              decoration: const InputDecoration(
                hintText: "Enter email address",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email_outlined),

                ),
                errorStyle: TextStyle(
                  fontSize: 14.0,

                ),

              ),
              validator:(textValue) {
                if(textValue == null || textValue.isEmpty) {
                  return 'Please Enter email address';
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.done,
                obscureText: _obtxt1,
                cursorColor: kPrimaryColor,
                decoration:  InputDecoration(
                  hintText: "Enter password",
                    suffixIcon:IconButton(onPressed: () {
                      setState(() {
                        setState(() {
                          _obtxt1 = !_obtxt1;
                        });
                      });
                    }, icon: Icon( _obtxt1? Icons.visibility : Icons.visibility_off,)),

                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.lock),

                  ),
                  errorStyle: TextStyle(
                    fontSize: 14.0,

                  ),

                ),
                validator: (textValue) {
                  if(textValue == null || textValue.isEmpty) {
                    return 'Please Enter Password';
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
      var cond=data['result'];

       if(cond==true) {
        await prefs.setInt('id', data['id']);
        await prefs.setBool("result", true);
        await prefs.setString("user_Email", data['G_username']);
        await prefs.setString("User_Typ", data['User_Typ']);
        await prefs.setString("Name", data['Name']);
        bool cimgpathexists1=data["cimgpathexists1"];
        bool cimgpathexists2=data["cimgpathexists2"];

        await prefs.setBool("cimgpathexists1", cimgpathexists1);
        await prefs.setBool("cimgpathexists2", cimgpathexists2);

        if(cimgpathexists1){
          await prefs.setString("img1", data['img1']);
          await prefs.setString("imgname1", data['imgname1']);
        }
        if(cimgpathexists2){
          await prefs.setString("img2", data['img2']);
          await prefs.setString("imgname2", data['imgname2']);
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
