import 'package:flutter/material.dart';
import 'package:gka/screens/welcomescreen/welcome_screen.dart';
import 'package:gka/tabs/aboutustab.dart';
import 'package:gka/tabs/bmembertab.dart';
import 'package:gka/widgets/navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Tabs/contacttab.dart';
import 'Tabs/gallerytab.dart';
import 'Tabs/socmediatab.dart';
import 'Tabs/hometab.dart';
import 'constants.dart';
import 'mainwelcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool arrow_l=false;
  bool arrow_r=true;


  late final TabController tabController=TabController(length: 6, vsync: this,initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    double mw = MediaQuery.of(context).size.width;

    return DefaultTabController(
          length: 6,
          child: Scaffold(
            appBar: AppBar(
              leading:  Align(alignment: Alignment.bottomCenter,child:  IconButton(onPressed: (){
                tabController.animateTo(
                  tabController.index=0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              }, icon: const Icon(Icons.home)),),
              title:   const Text(
                'G K A' ,
                style: TextStyle(fontSize: 20.0),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30.0),
                  child: Row(
                    children: [
                      Visibility(
                        visible: arrow_l,
                        child: IconButton(onPressed: () {
                          tabController.animateTo(
                            tabController.index=0,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease,
                          );
                            setState(() {
                              arrow_l=!arrow_l;
                              arrow_r=!arrow_r;
                            });

                        }, icon:const Icon(Icons.keyboard_double_arrow_left)),
                      ),
                      Expanded(
                        child: TabBar(
                          controller:tabController ,
                            isScrollable: true,
                            labelPadding:EdgeInsets.only(right: mw/20,left: mw/20),
                            unselectedLabelColor: Colors.white.withOpacity(0.5),
                            indicatorColor: Colors.white,
                            tabs: const [
                              Tab(
                                child: Text('Home'),
                              ),
                              Tab(
                                child: Text('About Us'),

                              ),
                              Tab(
                                child: Text('Gallery'),
                              ),
                              Tab(
                                child: Text('Social Media'),
                              ),
                              Tab(
                                child: Text('Contact'),
                              ),
                              Tab(
                                child: Text('Became a Member'),
                              )
                            ]),
                      ),
                       Visibility(
                        visible: arrow_r,
                        child: IconButton(onPressed: () {
                          tabController.animateTo(
                            tabController.index=5,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.ease,
                          );
                          setState(() {
                            arrow_l=!arrow_l;
                            arrow_r=!arrow_r;
                          });

                        }, icon:const Icon(Icons.keyboard_double_arrow_right)),
                      ),
                    ],
                  )),
              actions:  <Widget>[
                Padding(
                  padding: const EdgeInsets.all(6.5),
                  child: SizedBox(
                      height: 20,width: 95,
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.blue),
                              minimumSize: MaterialStatePropertyAll(Size(50, 35))),
                          onPressed: () async{
                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                            int id = prefs.getInt('id') ?? 0;
                            await Future.delayed(const Duration(seconds: 1), () {
                              if(id>0){
                                if (!mounted) return;
                                NavigationPushreplace(context,const mainwelcome());
                              }else{
                                NavigationPushreplace(context,const WelcomeScreen());
                              }
                            });
                          },
                          child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login'),
                      SizedBox(width: 2,),
                      Icon(Icons.login)
                    ],
                  ))),
                ),
              ],
            ),
            body:TabBarView(
              controller: tabController,
              children: const [
                hometab(),
                aboutustab(),
                gallerytab(),
                socmediatab(),
                contacttab(),
                bmemeber(),
              ],
            ),
            bottomNavigationBar: Container(
              color: Colors.orangeAccent,
              child: const Text(copyright,style: TextStyle(fontSize: 9),),
            ),
          ),
        );
  }
}
