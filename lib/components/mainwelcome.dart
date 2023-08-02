import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gka/components/login_page.dart';
import 'package:gka/components/screen/screenbusiness.dart';
import 'package:gka/components/screen/screencontact.dart';
import 'package:gka/components/screen/screenhome.dart';
import 'package:gka/components/screen/screenprofile.dart';
import 'package:gka/components/screen/screenprofilephoto.dart';
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
    homescreen(),
    profilescreen(),
    contactscreen(),
    businessscreen(),
    profilephotoscreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("$Name"),
              accountEmail: Text("$user_Email"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                    child:Image.network("http://e-gam.com/GKA/Logo/GKA%20logo.jpg")),
              ),
              decoration: BoxDecoration(color: Colors.deepOrange),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.share),
                title: Text('Profile'),
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
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_phone),
                    title: Text('Contact Information'),
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.family_restroom),
                    title: Text('Family Information'),
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Profile Image'),
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Card(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginPage()));
                },
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("GKA"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            SystemNavigator.pop();
          },
            icon: Icon(Icons.exit_to_app),),
        ],
      ),
      body: _widgetOption[_selectedIndex],
    );
  }
}
