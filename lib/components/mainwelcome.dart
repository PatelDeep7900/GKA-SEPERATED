import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:gka/Screens/Welcome/welcome_screen.dart';
import 'package:gka/components/screen/approve_list.dart';
import 'package:gka/components/screen/basicinfoscreen.dart';
import 'package:gka/components/screen/sceenfamilyinfo.dart';
import 'package:gka/components/screen/screenbusiness.dart';
import 'package:gka/components/screen/screencontact.dart';
import 'package:gka/components/screen/screenfamilydtl.dart';
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
  bool _adm = false;
  bool _hphone = false;
  bool _hmobile = false;
  bool _hemail = false;
  bool? imgavl = false;

  int? id = 0;
  int? User_Approv = 0;
  int _selectedIndex = 0;
  int status = 0;

  String imgpath001 = "";
  String? user_Email = "";
  String? Name = "";
  String? User_Typ = "";
  String? img1 = "";
  String? img2 = "";
  String? imgupload1 = "";

  addprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_Email = prefs.get("user_Email").toString();
      Name = prefs.get("Name").toString();
      User_Typ = prefs.get("User_Typ").toString();
      imgavl = prefs.getBool("imgavl");
      imgupload1 = prefs.get("imgupload1").toString();
      User_Approv = prefs.getInt("User_Approv");
      id = prefs.getInt("id");

      if (User_Typ == "AU") {
        _adm = true;
      }

      String? a = prefs.getString("h_phone");
      if (a == "true") {
        setState(() {
          _hphone = true;
        });
      } else {
        setState(() {
          _hphone = false;
        });
      }

      String? b = prefs.getString("h_mobile");
      if (b == "true") {
        setState(() {
          _hmobile = true;
        });
      } else {
        setState(() {
          _hmobile = false;
        });
      }

      String? c = prefs.getString("h_email");
      if (c == "true") {
        setState(() {
          _hemail = true;
        });
      } else {
        setState(() {
          _hemail = false;
        });
      }

      img1 = prefs.getString("img1");
      img2 = prefs.getString("img2");
    });

    // if (User_Approv == 0) {
    //   setState(() {
    //     _selectedIndex = 8;
    //   });
    // }

  }

  Future<void> addsecurity(bool val, String field) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? _id = prefs.getInt("id");

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_security';
      final response = await http.post(Uri.parse(url),
          body: {'id': _id.toString(), 'val': val.toString(), 'field': field});
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data['result'] == true) {
          if(!mounted)return;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Success')));
        } else {
          if(!mounted)return;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data['result']}')));
        }
      }
    } on Exception catch (e) {
      if(!mounted)return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }


  static  List<Widget> _widgetOption = <Widget>[
    test_welcomepage(),
    profilescreen(),
    basicinfoscreen(),
    contactscreen(),
    businessscreen(),
    SetPhotoScreen(),
    SetPhotoScreen2(),
    DataPage(),
    familydtlsscreen(),
    familyinfoscreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      status = index;
    });
  }

  @override
  void initState() {
    addprefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        onDrawerChanged: (isOpened) {
          return setState(() {});
        },
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("$Name"),
                accountEmail: Text("$user_Email"),
                currentAccountPictureSize: const Size.fromRadius(43),
                currentAccountPicture: CircleAvatar(
                  child: CircleAvatar(
                      radius: 43,
                      backgroundImage: NetworkImage(
                          "http://e-gam.com/img/GKAPROFILE/$id/$imgupload1")),
                ),
                decoration: const BoxDecoration(color: Color(0xd9fd6d0c)),
              ),
              Card(
                color: status == 0 ? const Color(0xff233743) : null,
                child: ListTile(
                  leading: Icon(Icons.home,
                      color: status == 0 ? Colors.white : null),
                  title: Text(
                    'Home',
                    style: TextStyle(color: status == 0 ? Colors.white : null),
                  ),
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                color: status == 1 ? const Color(0xff233743) : null,
                child: ListTile(
                  leading: Icon(Icons.person,
                      color: status == 1 ? Colors.white : null),
                  trailing: Icon(Icons.share,
                      color: status == 1 ? Colors.white : null),
                  title: Text(
                    'Profile',
                    style: TextStyle(color: status == 1 ? Colors.white : null),
                  ),
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context);
                  },
                ),
              ),
              Card(
                child: ExpansionTile(
                  backgroundColor: Colors.white30,
                  title: const Text("Profile Edit"),
                  leading: const Icon(Icons.person),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: const Text('Basic Information'),
                      onTap: () {
                        _onItemTapped(2);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.contact_phone),
                      title: const Text('Contact Information'),
                      onTap: () {
                        _onItemTapped(3);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.business_center_sharp),
                      title: const Text('Business Information'),
                      onTap: () {
                        _onItemTapped(4);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.family_restroom_rounded),
                      title: const Text('Family Details'),
                      onTap: () {
                        _onItemTapped(8);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.family_restroom_outlined),
                      title: const Text('Family Information'),
                      onTap: () {
                        _onItemTapped(9);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Profile Image'),
                      onTap: () {
                        _onItemTapped(5);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Image'),
                      onTap: () {
                        _onItemTapped(6);
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
                    title: const Text(
                      'Approved List',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () async {
                      _onItemTapped(7);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Card(
                child: ExpansionTile(
                  backgroundColor: Colors.white30,
                  title: const Text("setting & privacy"),
                  leading: const Icon(Icons.settings),
                  onExpansionChanged: (value) async {
                    addprefs();
                  },
                  children: [
                    ListTile(
                      leading: const Icon(Icons.phone_disabled),
                      trailing: Switch(
                          value: _hphone,
                          onChanged: (val) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("h_phone", val.toString());
                            setState(() {
                              _hphone = !_hphone;
                            });
                            addsecurity(_hphone, "h_phone");
                          }),
                      title: const Text('Hide Phone'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.mobile_off),
                      title: const Text('Hide Mobile'),
                      trailing: Switch(
                          value: _hmobile,
                          onChanged: (val) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("h_mobile", val.toString());
                            setState(() {
                              _hmobile = !_hmobile;
                            });
                            addsecurity(_hmobile, "h_mobile");
                          }),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Hide Email'),
                      trailing: Switch(
                          value: _hemail,
                          onChanged: (val) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString("h_email", val.toString());
                            setState(() {
                              _hemail = !_hemail;
                            });
                            addsecurity(_hemail, "h_email");
                          }),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Account Delete'),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    if(!mounted)return;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    if(!mounted)return;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => WelcomeScreen()));
                  },
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black12,
        appBar: AppBar(
          backgroundColor: const Color(0xd9fd6d0c),
          title: const Text("GKA"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  if (Platform.isAndroid) {
                    FlutterExitApp.exitApp();
                  }
                  if (Platform.isIOS) {
                    FlutterExitApp.exitApp(iosForceExit: true);
                  }
                },
                icon: const Icon(Icons.exit_to_app))
          ],
        ),
        body: _widgetOption[_selectedIndex],
      ),
    );
  }
}
