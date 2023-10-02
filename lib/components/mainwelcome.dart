import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gka/Screens/Welcome/welcome_screen.dart';
import 'package:gka/components/screen/basicinfoscreen.dart';
import 'package:gka/components/screen/screencontact.dart';

import 'package:gka/components/screen/screenprofile.dart';
import 'package:gka/imagepicker/image1.dart';
import 'package:gka/imagepicker/image2.dart';
import 'package:gka/test/test_welcomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mainwelcome extends StatefulWidget {
  const mainwelcome({super.key});
  @override
  State<mainwelcome> createState() => _mainwelcomeState();
}

class _mainwelcomeState extends State<mainwelcome> {
  int _selectedIndex = 0;
  int status = 0;
  String? user_Email = "";
  String? Name = "";
  String? User_Typ = "";

  addprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_Email = prefs.get("user_Email").toString();
      Name = prefs.get("Name").toString();
      User_Typ = prefs.get("User_Typ").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addprefs();
  }

  static const List<Widget> _widgetOption = <Widget>[
    test_welcomepage(),
    profilescreen(),
    basicinfoscreen(),
    contactscreen(),
    SetPhotoScreen(),
    SetPhotoScreen2()
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
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("$Name"),
                accountEmail: Text("$user_Email"),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                      child:Image.network("http://e-gam.com/img/TestImageProfile/35003/1/1.jpg")),
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
        ),
        body: _widgetOption[_selectedIndex],
      ),
    );
  }
}
