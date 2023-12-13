import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../homepage.dart';
import '../../mainwelcome.dart';
import '../../constants.dart';
import 'package:gka/popupbutton.dart';
import '../../screens/Loginscreen/screen_forgotpass.dart';
import '../../screens/signupscreen/already_have_an_account_acheck.dart';
import '../../screens/signupscreen/signup_screen.dart';

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
  final TextEditingController _cemail=TextEditingController();
  final TextEditingController _cpass=TextEditingController();

bool _isLoadingbtn1=false;

  Future<void> loginapi(String Emailval,String Passval)async{
    try{
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

          setState(() {
            _isLoadingbtn1=false;
          });

          telegramapi("login success \n ${Emailval}");

          await prefs.setInt('id', data['id']);
          await prefs.setBool("result", true);
          await prefs.setInt("User_Approv", data['User_Approv']);
          await prefs.setString("user_Email", data['G_username']);
          await prefs.setString("User_Typ", data['User_Typ']);
          await prefs.setString("h_phone", data['h_phone']);
          await prefs.setString("Name", data['Name']);
          await prefs.setString("h_mobile", data['h_mobile']);
          await prefs.setString("h_email", data['h_email']);
          await prefs.setString("val_Country", data['val_Country']);
          await prefs.setString("val_State", data['val_State']);
          await prefs.setString("val_City", data['val_City']);
          await prefs.setBool("imgavl", data["imgavl"]);
          await prefs.setString("imgupload1", data['imgupload1']);
          await prefs.setBool("imgavl2", data["imgavl2"]);
          await prefs.setString("imgupload2", data['imgupload2']);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainwelcome()));
        }else{
          setState(() {
            _isLoadingbtn1=false;
          });
          await prefs.setBool("result", false);
          telegramapi('invalid username or password \n email-${Emailval} \n password-${Passval}');
          warningpopup(context, "invalid username or password");

        }
      }else{
        setState(() {
          _isLoadingbtn1=false;
        });
        telegramapi('server not responding');
        await prefs.setBool("result", false);
        errorpopup(context, "server not responding");
      }
    }on Exception catch (e) {
      setState(() {
        _isLoadingbtn1=false;
      });
      errorpopup(context,e.toString());
      telegramapi(e.toString());
      rethrow;
    }
  }

  void _handleLoginUser() {
    if (_loginFormKey.currentState!.validate()) {
     setState(() {
       _isLoadingbtn1=true;
     });


      loginapi(_cemail.text, _cpass.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: TextFormField(
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
            ),

            TextFormField(
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
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                errorStyle: const TextStyle(
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
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "login_btn",
              child: ElevatedButton(
                onPressed: () {
                  _handleLoginUser();
                },
                child: _isLoadingbtn1? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...', style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                    CircularProgressIndicator(color: Colors.white,),
                  ],
                ) :  const Text('LOGIN'),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Hero(
              tag: "forgot_btn",
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const forgotpass();
                      },
                    ),
                  );
                },
                child: const Text(
                  "Forgot Password",
                ),
              ),
            ),
            const SizedBox(height: defaultPadding),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SignUpScreen();
                      },
                    ),
                  );
                },
              ),
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



}
