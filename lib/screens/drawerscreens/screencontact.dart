import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skeletonizer/skeletonizer.dart';


import '../../../constants.dart';
import '../../../popupbutton.dart';


class contactscreen extends StatefulWidget {
  const contactscreen({super.key});

  @override
  State<contactscreen> createState() => _contactscreenState();
}

class _contactscreenState extends State<contactscreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _C_code = TextEditingController();
  final TextEditingController _Phone = TextEditingController();
  final TextEditingController _Mob = TextEditingController();
  final TextEditingController _Email = TextEditingController();
  bool _isLoading = false;
  bool _isLoadingbtn1=false;
  bool _isLoadingbtn2=false;

  void getpref() async {
    setState(() {
      _isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      var url =
          "http://e-gam.com/GKARESTAPI/c_cscpicker?cond=contactinfoget&id=${id}";
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
  void getpref1() async {
    setState(() {
      _isLoadingbtn2 = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      var url =
          "http://e-gam.com/GKARESTAPI/c_cscpicker?cond=contactinfoget&id=${id}";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          _C_code.text=data['C_code'];
          _Phone.text=data['Phone'];
          _Mob.text=data['Mob'];
          _Email.text=data['Email'];
          _isLoadingbtn2 = false;
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> _doSomething() async{
    setState(() {
      _isLoadingbtn1=true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id=prefs.getInt("id");
    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_cscpicker';
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
          if(!mounted)return;
          sucesspopup(context, 'Data Saved SuccessFully');
          setState(() {
            _isLoadingbtn1=false;
          });
        } else {
          if(!mounted)return;
          warningpopup(context, data['msg']);
          setState(() {
            _isLoadingbtn1=false;
          });
        }
      }
    }on Exception catch (e) {
      if(!mounted)return;
      errorpopup(context, e.toString());
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Expanded(
            child: Hero(
              tag: "submit btn",
              child:  ElevatedButton(
                onPressed: (){_doSomething();},
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
          const SizedBox(width: 10,),
          Expanded(
            child:  Hero(
              tag: "reset_btn",
              child: ElevatedButton(
                onPressed: (){getpref1();},
                child: _isLoadingbtn2? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Loading...', style: TextStyle(fontSize: 20),),
                    SizedBox(width: 10,),
                    CircularProgressIndicator(color: Colors.white,),
                  ],
                ) :  Text('RESET'.toUpperCase()),
              ),
            ),


          )
        ],),
      ),
      body:Skeletonizer(
        enabled: _isLoading,
            child: SingleChildScrollView(
        child: Card(
            child:Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: defaultPadding),
                  const Center(child: Text("Contact Information",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                  const Divider(),
                  const SizedBox(height: defaultPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      controller: _C_code,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        counterText: "",
                        hintText: "Country Code",
                        label: Chip(label: Text('Country Code')),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.numbers),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      controller: _Phone,
                      maxLength: 30,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        counterText: "",
                        hintText: "Home Phone",
                        label: Chip(label: Text('Home Phone')),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.phone),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      maxLength: 30,
                      controller: _Mob,
                      textInputAction: TextInputAction.next,
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        counterText: "",
                        label: Chip(label: Text('Mobile Number')),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.mobile_friendly),
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
                      maxLength: 100,
                      decoration: const InputDecoration(
                        hintText: "Email Address",
                        counterText: "",
                        label: Chip(label: Text('Email Address')),
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
          ),
    );
  }
}

