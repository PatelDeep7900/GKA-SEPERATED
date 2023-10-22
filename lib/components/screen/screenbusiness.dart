import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../constants.dart';
class businessscreen extends StatefulWidget {
  const businessscreen({super.key});

  @override
  State<businessscreen> createState() => _businessscreenState();
}

class _businessscreenState extends State<businessscreen> {


  TextEditingController _B_Website = TextEditingController();
  TextEditingController _B_Detail = TextEditingController();
  TextEditingController _B_location = TextEditingController();
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

          _B_Website.text=data['B_Website'];
          _B_Detail.text=data['B_Detail'];
          _B_location.text=data['B_location'];


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
            'cond': "businessdetailsupdate",
            'B_Website': _B_Website.text.toString(),
            'B_Detail': _B_Detail.text.toString(),
            'B_location': _B_location.text.toString(),
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
                  controller: _B_Website,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {

                  },
                  decoration: const InputDecoration(
                    hintText: "Business Website",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),

                ),

                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _B_Detail,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Type Of Business",
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
                    controller: _B_location,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Business Location",
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

