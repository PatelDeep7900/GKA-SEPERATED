import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gka/components/screen/forgototpscreen.dart';
import 'package:gka/otp_page.dart';
import 'package:gka/passset.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class forgotpass extends StatefulWidget {
  const forgotpass({super.key});

  @override
  State<forgotpass> createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
   bool _isLoadingbtn1=false;
  final TextEditingController _G_username = TextEditingController();
  final _globkey = GlobalKey<FormState>();

  void _handleSignup() {

    if (_globkey.currentState!.validate()) {
      _forgotpass();
    }
  }

  void _forgotpass() async{

    setState(() {
      _isLoadingbtn1=true;
    });

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_forgotpass';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            "G_username":_G_username.text,
            "cond":'userexistornot'

          }

      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
          if(data['existornot']==true){

            final SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('id', data['id'].toString());
            await prefs.setString('G_username', data['G_username']);
            await prefs.setString('Name', data['Name']);

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => forgototppass()));

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(data['msg'])));
          }
        print(data);
        setState(() {
          _isLoadingbtn1=false;
        });

      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));
      setState(() {
        _isLoadingbtn1=false;
      });
      print('error caught: $e');
      rethrow;
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xd9fd6d0c),
        title: const Text("GKA"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _globkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: defaultPadding),
              const Center(child: Text("Forgot Password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
              const Divider(),
              const SizedBox(height: defaultPadding),
              TextFormField(
                controller: _G_username,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autovalidateMode: AutovalidateMode.onUserInteraction,

                cursorColor: kPrimaryColor,
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
                  hintText: "Email-Address",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(Icons.email_outlined),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    child: Hero(
                      tag: "submit btn",
                      child:  ElevatedButton(
                        onPressed: (){
                          _handleSignup();
                        },
                        child: _isLoadingbtn1? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Loading...', style: TextStyle(fontSize: 20),),
                            SizedBox(width: 10,),
                            CircularProgressIndicator(color: Colors.white,),
                          ],
                        ) :  Text('SUBMIT'.toUpperCase()),
                      ),
                    ),
                  ),

                ],),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
