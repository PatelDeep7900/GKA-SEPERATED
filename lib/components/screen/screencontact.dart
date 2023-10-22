import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../constants.dart';
class contactscreen extends StatefulWidget {
  const contactscreen({super.key});

  @override
  State<contactscreen> createState() => _contactscreenState();
}

class _contactscreenState extends State<contactscreen> {


  TextEditingController _C_code = TextEditingController();
  TextEditingController _Phone = TextEditingController();
  TextEditingController _Mob = TextEditingController();
  TextEditingController _Email = TextEditingController();
bool _isLoading=false;

  void getpref() async {
    setState(() {
      _isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      var url =
          "http://192.168.10.141:8084/GKARESTAPI/c_cscpicker?cond=contactinfoget&id=${id}";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {

          _C_code.text=data['C_code'];
          _Phone.text=data['Phone'];
          _Mob.text=data['Mob'];
          _Email.text=data['Email'];


          _isLoading = false;
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> _doSomething() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id=prefs.getInt("id");
    try {

      String url = 'http://192.168.10.141:8084/GKARESTAPI/c_cscpicker';
      print(url);
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'cond': "contactinfoupdate",
            'C_code': _C_code.text.toString(),
            'Phone': _Phone.text.toString(),
            'Mob': _Mob.text.toString(),
            'Email': _Email.text.toString(),
            'id':id.toString()
          }

      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        bool result = data['result'];
        if (result== true) {



          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Data Saved SuccessFully...')));
        } else {
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
    getpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:SingleChildScrollView(
        child: Card(
          child:Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),

                Center(child: Text("Contact Information",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                Divider(),
                const SizedBox(height: defaultPadding),


                TextFormField(
                  controller: _C_code,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {

                  },
                  decoration: const InputDecoration(
                    hintText: "Country Code",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),

                ),

                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _Phone,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Home Phone",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),


                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _Mob,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Mobile Number",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),


                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _Email,
                    textInputAction: TextInputAction.done,

                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),

                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "submit_btn",
                  child: ElevatedButton(
                    onPressed: () {
                      _doSomething();
                    },
                    child: const Text(
                      "SUBMIT",
                    ),
                  ),
                ),

                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "reset_btn",
                  child: ElevatedButton(
                    onPressed: () {
                        getpref();
                    },
                    child: const Text(
                      "RESET",
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

