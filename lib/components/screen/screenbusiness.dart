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

  final TextEditingController _B_Website = TextEditingController();
  final TextEditingController _B_Detail = TextEditingController();
  final TextEditingController _B_location = TextEditingController();
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
      print(url);
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
  void getpref1() async {
    setState(() {
      _isLoadingbtn2 = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      var url =
          "http://e-gam.com/GKARESTAPI/c_cscpicker?cond=contactinfoget&id=${id}";
      print(url);
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          _B_Website.text=data['B_Website'];
          _B_Detail.text=data['B_Detail'];
          _B_location.text=data['B_location'];
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
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Data Saved SuccessFully...')));
          setState(() {
            _isLoadingbtn1=false;
          });
        } else {
          if(!mounted)return;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data['msg'])));
          setState(() {
            _isLoadingbtn1=false;
          });
        }
      }
    }on Exception catch (e) {
      if(!mounted)return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Server not Responding')));
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

      body:_isLoading == true
          ? const Center(child: CircularProgressIndicator())
          :SingleChildScrollView(
        child: Card(
          child:Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),
                const Center(child: Text("Business Information Edit",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                const Divider(),
                const SizedBox(height: defaultPadding),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _B_Website,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Business Website",
                      label: Chip(label: Text('Business Website')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.link),
                      ),
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
                      label: Chip(label: Text('Type Of Business')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.business),
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
                      label: Chip(label: Text('Business Location')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.map),
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

