import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../../constants.dart';
import '../welcomescreen/welcome_screen.dart';


class passchange extends StatefulWidget {
  const passchange({super.key});

  @override
  State<passchange> createState() => _passchange();
}

class _passchange extends State<passchange> {

  final TextEditingController _oldpass = TextEditingController();
  final TextEditingController _newpass = TextEditingController();
  final TextEditingController _confpass = TextEditingController();
  final _globkey = GlobalKey<FormState>();

  bool _v1=true;
  bool _v2=true;
  bool _v3=true;


  final bool _isLoading = false;
  final bool _isLoadingbtn1=false;

  void _handleSignup() {

    if (_globkey.currentState!.validate()) {
      passchange();
    }
  }

 void passchange() async{
   final SharedPreferences prefs = await SharedPreferences.getInstance();
   int? id=prefs.getInt("id");


   try {
     String url = 'http://e-gam.com/GKARESTAPI/c_passwordchange';
     final response = await http.post(
         Uri.parse(url),
         body:
         {
           'id': id.toString(),
           'oldpass': _oldpass.text,
           'newpass': _newpass.text,
           'confpass': _confpass.text,

         }

     );
     if (response.statusCode == 200) {
       var data = jsonDecode(response.body);

       if(data['firstcond']==true){

         if(data['passmatch']==true){

           if(data['result']==true){



             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(data['msg'])));

             SharedPreferences prefs =
             await SharedPreferences.getInstance();
             prefs.clear();
             if(!mounted)return;
             Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (ctx) => WelcomeScreen()));

           }else{
             ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(data['msg'])));
           }


         }else{
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text('Oldpassword Not Matched...')));
         }

       }else{
         ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(data['msg'])));
       }





     }
   }on Exception catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('Server not Responding')));
     print('error caught: $e');
     rethrow;
   }

 }




  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: Hero(
              tag: "submit btn",
              child:  ElevatedButton(
                onPressed: (){_handleSignup();},
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
      body: _isLoading == true
          ? const Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Card(
          child:Form(
            key: _globkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),

                const Center(child: Text("Password Change",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),

                const Divider(),
                const SizedBox(height: defaultPadding),

                TextFormField(
                  controller: _oldpass,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,                  cursorColor: kPrimaryColor,
                  obscureText: _v1,
                  enableSuggestions: false,
                  autocorrect: false,
                  maxLength: 20,
                  validator: (value) {
                    if(value!.isEmpty){
                      return 'Please enter Old password';
                    }
                    if(value == _newpass.text){
                      return 'Old Pass & New Password Are Same...';
                    }
                    if(value.length<4){
                      return 'Please Enter Atleast 4 Character Password';
                    }

                    return null;
                  },

                  decoration:  InputDecoration(
                    hintText: "Old Password",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.password_outlined),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_v1
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                              () {
                                _v1 = !_v1;
                          },
                        );
                      },
                    ),


                  ),

                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child:         TextFormField(
                    controller: _newpass,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.next,                  cursorColor: kPrimaryColor,
                    obscureText: _v2,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLength: 20,
                    validator: (val){
                      if(val!.isEmpty){
                        return 'Please enter New password';
                      }
                      if(val.length<4){
                        return 'Please Enter Atleast 4 Character Password';
                      }


                    },

                    decoration:  InputDecoration(
                      hintText: "New Password",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.password_rounded),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_v2
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                                () {
                                  _v2 = !_v2;
                            },
                          );
                        },
                      ),

                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _confpass,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,                  cursorColor: kPrimaryColor,
                    obscureText: _v3,
                    enableSuggestions: false,
                    autocorrect: false,
                    maxLength: 20,
                    validator: (val){
                      if(val!.isEmpty){
                        return 'Please enter confirm password';
                      }
                      if(val != _newpass.text){
                        return 'New Password & Confirm password not matching';
                      }
                      if(val.length<4){
                        return 'Please Enter Atleast 4 Character Password';
                      }



                    },

                    decoration:  InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.password_outlined),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_v3
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(
                                () {
                                  _v3 = !_v3;
                            },
                          );
                        },
                      ),

                    ),

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

