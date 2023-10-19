import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:gka/Screens/Welcome/welcome_screen.dart';
import 'package:gka/components/screen/approve_list.dart';
import 'package:gka/components/screen/basicinfoscreen.dart';
import 'package:gka/components/screen/screencontact.dart';

import 'package:gka/components/screen/screenprofile.dart';
import 'package:gka/imagepicker/image1.dart';
import 'package:gka/imagepicker/image2.dart';
import 'package:gka/test/test_welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class mainwelcome extends StatefulWidget {
  const mainwelcome({super.key});

  @override
  State<mainwelcome> createState() => _mainwelcomeState();
}

class _mainwelcomeState extends State<mainwelcome> {

  String imgpath001="";
  bool _adm=true;

  bool _hphone=false;
  bool _hmobile=false;
  bool _hemail=false;


  int _selectedIndex = 0;
  int status = 0;
  String? user_Email = "";
  String? Name = "";
  String? User_Typ = "";

  String? img1 = "";
  String? img2 = "";

  bool? cimgpathexists1=false;
  bool? cimgpathexists2=false;




  addprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_Email = prefs.get("user_Email").toString();
      Name = prefs.get("Name").toString();
      User_Typ = prefs.get("User_Typ").toString();
      if(User_Typ=="AU"){
        _adm=true;
      }
    
      String? a=prefs.getString("h_phone");
      if(a=="true"){setState(() {_hphone=true;});
      }else{setState(() {_hphone=false;});}

      String? b=prefs.getString("h_mobile");
      if(b=="true"){setState(() {_hmobile=true;});
      }else{setState(() {_hmobile=false;});}

      String? c=prefs.getString("h_email");
      if(c=="true"){setState(() {_hemail=true;});
      }else{setState(() {_hemail=false;});}

      
      cimgpathexists1=prefs.getBool("cimgpathexists1");
      cimgpathexists2=prefs.getBool("cimgpathexists2");



      img1=prefs.getString("img1");
      img2=prefs.getString("img2");
    });

  }

  @override
  void initState() {
    addprefs();
    super.initState();
  }

  static const List<Widget> _widgetOption = <Widget>[
    test_welcomepage(),
    profilescreen(),
    basicinfoscreen(),
    contactscreen(),
    SetPhotoScreen(),
    SetPhotoScreen2(),
    ApproveList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      status=index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          return setState(() {

          });
        },
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("$Name"),
                accountEmail: Text("$user_Email"),
                currentAccountPictureSize:Size.fromRadius(43),
                currentAccountPicture: CircleAvatar(
                  child: cimgpathexists1==true ? CircleAvatar(radius: 43,backgroundImage: NetworkImage(img1!),) :Image.asset("assets/images/nopic.png"),
                ),
                decoration: const BoxDecoration(color: Color(0xd9fd6d0c)),
              ),
              Card(
                color: status==0?const Color(0xff233743):null,
                child: ListTile(
                  leading: Icon(Icons.home,color: status==0?Colors.white:null),
                  title: Text('Home',style: TextStyle(color: status==0?Colors.white:null),),
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                color: status==1?const Color(0xff233743):null,
                child: ListTile(
                  leading: Icon(Icons.person,color: status==1?Colors.white:null),
                  trailing: Icon(Icons.share,color: status==1?Colors.white:null),
                  title: Text('Profile',style: TextStyle(color: status==1?Colors.white:null),),
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ExpansionTile(
                  backgroundColor: Colors.white30,
                  title: Text("Profile Edit"),
                  leading: Icon(Icons.person),
                  children: [
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('Basic Information'),
                      onTap: () {
                        _onItemTapped(2);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.contact_phone),
                      title: Text('Contact Information'),
                      onTap: () {
                        _onItemTapped(3);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Profile Image'),
                      onTap: () {
                        _onItemTapped(4);
                        Navigator.pop(context);
                      },
                    ),

                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text('Image'),
                      onTap: () {
                        _onItemTapped(5);
                        Navigator.pop(context);
                      },
                    ),


                  ],
                ),
              ),
              const Divider(),


              Visibility(
                visible: _adm,
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.admin_panel_settings),
                    title: const Text('Approved List',style: TextStyle(color: Colors.red),),
                    onTap: () async {
                      _onItemTapped(6);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Card(
                child: ExpansionTile(
                  backgroundColor: Colors.white30,
                  title: Text("setting & privacy"),
                  leading: Icon(Icons.settings),
                  onExpansionChanged: (value) async {
                    addprefs();
                  },
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone_disabled),
                      trailing: Switch(value: _hphone, onChanged: (val) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("h_phone", val.toString());
                        setState(() {
                          _hphone=!_hphone;
                        });
                        addsecurity(_hphone, "h_phone");

                      }),
                      title: const Text('Hide Phone'),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.mobile_off),
                      title: const Text('Hide Mobile'),
                      trailing: Switch(value: _hmobile, onChanged: (val){
                        setState(() {
                          _hmobile=!_hmobile;
                        });
                        addsecurity(_hmobile, "h_mobile");

                      }),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Hide Email'),
                      trailing: Switch(value: _hemail, onChanged: (val){
                        setState(() {
                          _hemail=!_hemail;

                        });
                        addsecurity(_hemail, "h_email");


                      }),
                      onTap: () {

                      },
                    ),

                  ],
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: const Text('Account Delete'),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>WelcomeScreen()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>WelcomeScreen()));
                  },
                ),
              ),

            ],
          ),
        ),
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: Color(0xd9fd6d0c),
          title: const Text("GKA"),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {
              if(Platform.isAndroid){
                FlutterExitApp.exitApp();
              }
              if(Platform.isIOS){
                FlutterExitApp.exitApp(iosForceExit: true);

              }

            }, icon: Icon(Icons.exit_to_app))
          ],

        ),
        body: _widgetOption[_selectedIndex],
      ),
    );
  }

  Future<void> addsecurity(bool val,String field) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? _id=prefs.getInt("id");

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_security';
      final response = await http.post(
          Uri.parse(url),
          body:
          {
            'id': _id.toString(),
            'val': val.toString(),
            'field':field
          }

      );
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if(data['result']==true){
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Success')));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data['result']}')));
        }


      }
    }on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server not Responding')));


      print('error caught: $e');
      rethrow;
    }

  }


}
