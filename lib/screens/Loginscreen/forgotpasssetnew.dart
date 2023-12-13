
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import 'login_screen.dart';

const Color primaryColor = Color(0xFF121212);

class forgotpasssetnew extends StatefulWidget {

  const forgotpasssetnew({super.key});

  @override
  State<forgotpasssetnew> createState() => _forgotpasssetnew();
}

class _forgotpasssetnew extends State<forgotpasssetnew> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _cpass = TextEditingController();
  final _globkey = GlobalKey<FormState>();

  bool _obtxt1=true;
  bool _obtxt2=true;

  void _handleSignup() {

    if (_globkey.currentState!.validate()) {
      _register();
    }
  }


  void _register()async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? G_username=prefs.getString("G_username");
    String? Name=prefs.getString("Name");



    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_forgotpass';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'G_username': G_username,
            'Name': Name,
            'pass':_pass.text,
            'cond':'forgotpassset'

          }

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        bool result=data['result'];
        if(result){
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SuccessFully done..")));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));

        }else{
          var errmsg=data['msg'];
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errmsg)));

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




  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orange,
        title: const Text('OTP Verification'),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _globkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1,),
              const Center(child: Text('Set Forgot password')),
              const Divider(),
              const SizedBox(height: defaultPadding / 1),
              TextFormField(
                controller: _pass,
                obscureText: _obtxt1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                maxLength: 20,
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter new password';
                  }else if(val.length<6){
                    return 'Must be more than 6 charater';
                  }
                },
                decoration:  InputDecoration(
                    hintText: "New Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock),
                    ),
                    suffixIcon:IconButton(onPressed: () {
                      setState(() {
                        setState(() {
                          _obtxt1 = !_obtxt1;
                        });
                      });
                    }, icon: Icon( _obtxt1
                        ? Icons.visibility
                        : Icons.visibility_off,))
                ),
              ),
              const SizedBox(height: defaultPadding / 1),
              TextFormField(
                controller: _cpass,
                maxLength: 20,
                obscureText: _obtxt2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                onSaved: (email) {},
                validator: (val){
                  if(val!.isEmpty){
                    return 'Please enter confirm password';
                  }
                  if(val != _pass.text){
                    return 'Confirm password not matching';
                  }


                },
                decoration:  InputDecoration(
                    hintText: "confirm Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.lock_reset),
                    ),
                    suffixIcon:IconButton(onPressed: () {
                      setState(() {
                        setState(() {
                          _obtxt2 = !_obtxt2;
                        });
                      });
                    }, icon: Icon( _obtxt2
                        ? Icons.visibility
                        : Icons.visibility_off,))

                ),
              ),
              const SizedBox(height: defaultPadding / 1),
              Center(
                child:CustomButton(
                  onPressed: () {
                    _handleSignup();
                  },
                  title: "Confirm",
                  color: primaryColor,
                  textStyle: theme.textTheme.subtitle1?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }
}

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
