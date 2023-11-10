//https://itecnote.com/tecnote/flutter-create-dynamic-textfield-when-button-click/#google_vignette
//https://medium.com/flutter-community/flutter-ide-shortcuts-for-faster-development-2ef45c51085b



import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../constants.dart';
class familydtlsscreen extends StatefulWidget {
  const familydtlsscreen({super.key});

  @override
  State<familydtlsscreen> createState() => _familydtlsscreenState();
}

class _familydtlsscreenState extends State<familydtlsscreen> {

  final TextEditingController _F_parents = TextEditingController();
  final TextEditingController _F_Spouse = TextEditingController();
  final TextEditingController _F_Native = TextEditingController();
  final TextEditingController _F_samajik = TextEditingController();
  final TextEditingController _F_abtfamily = TextEditingController();
  final TextEditingController _F_ext1 = TextEditingController();
  final TextEditingController _F_ext2 = TextEditingController();
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
          "http://e-gam.com/GKARESTAPI/c_cscpicker?cond=familydetailsget&id=${id}";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          _F_parents.text=data['Parent'];
          _F_Spouse.text=data['S_Parents'];
          _F_Native.text=data['Nat_City'];
          _F_samajik.text=data['S_sanstha'];
          _F_abtfamily.text=data['About_Family'];
          _F_ext1.text=data['Ext1'];
          _F_ext2.text=data['Ext2'];

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
          "http://e-gam.com/GKARESTAPI/c_cscpicker?cond=familydetailsget&id=${id}";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        setState(() {
          _F_parents.text=data['Parent'];
          _F_Spouse.text=data['S_Parents'];
          _F_Native.text=data['Nat_City'];
          _F_samajik.text=data['S_sanstha'];
          _F_abtfamily.text=data['About_Family'];
          _F_ext1.text=data['Ext1'];
          _F_ext2.text=data['Ext2'];
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
            'cond': "familydtupdate",
            'Parent': _F_parents.text.toString(),
            'S_Parents': _F_Spouse.text.toString(),
            'About_Family': _F_abtfamily.text.toString(),
            'Nat_City': _F_Native.text.toString(),
            'S_sanstha': _F_samajik.text.toString(),
            'Ext1': _F_ext1.text.toString(),
            'Ext2': _F_ext2.text.toString(),
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
     setState(() {
       _isLoadingbtn1=false;
     });
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
                const Center(child: Text("Family Details",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                const Divider(),
                const SizedBox(height: defaultPadding),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_parents,
                    textInputAction: TextInputAction.next,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Parents",
                      label: Chip(label: Text('Parents')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.group),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_Spouse,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Spouse Parents",
                      label: Chip(label: Text('Spouse Parents')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.group_outlined),
                      ),

                    ),

                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_Native,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Native:City/Country",
                      label: Chip(label: Text('Native:City/Country')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.location_on),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_samajik,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Name of Samajik Sanstha involved",
                      label: Chip(label: Text('Name of Samajik Sanstha involved')),
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
                    controller: _F_abtfamily,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "About Family",
                      label: Chip(label: Text('About Family')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.family_restroom),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_ext1,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Extra-1",
                      label: Chip(label: Text('Extra-1')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.info),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    controller: _F_ext2,
                    textInputAction: TextInputAction.done,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Extra-2",
                      label: Chip(label: Text('Extra-2')),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.info),
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

