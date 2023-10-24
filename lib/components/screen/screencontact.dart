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
          setState(() {
            _isLoadingbtn1=false;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['msg'])));
          setState(() {
            _isLoadingbtn1=false;
          });
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
          SizedBox(width: 10,),
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
      body: _isLoading == true
          ? Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
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

                
              ],
            ),
          ),
        ),
      ),

    );
  }
}

