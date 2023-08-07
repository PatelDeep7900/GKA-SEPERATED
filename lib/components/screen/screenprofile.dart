import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/welcomejson.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {

  bool _isloading = false;
  List<Result> result = [];


  int id=0;

  Future<void> profiledata()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   id= prefs.getInt("id")!;
    setState(() {
      _isloading =true;
    });
    var uri = "http://e-gam.com/GKARESTAPI/searchbyid?id=$id";
    final url = Uri.parse(uri);
    final response = await http.get(url);
    setState(() {
      Welcome welcome = Welcome.fromJson(json.decode(response.body));
      result = welcome.results;
    });
    setState(() {
      _isloading =false;
    });
  }
  @override
  void initState() {
    profiledata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: _isloading?
      Center(child: CircularProgressIndicator(),):
      result.isNotEmpty?
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     CircleAvatar(
                       backgroundColor: Colors.black,
                      radius: 80,
                     ),
                     Divider(),
                     SizedBox(height: 10,),
                     Expanded(
                       child: ListView(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Basic Information",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                             ),
                             Card(
                               color: Colors.grey,
                               child: Padding(
                                 padding: const EdgeInsets.only(bottom: 15),
                                 child: Column(
                                   children: [
                                   SizedBox(
                                     height: 45,
                                     child: ListTile(
                                       title: Text('Name:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                       subtitle: Text(result[0].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                     ),
                                   ),
                                   SizedBox(
                                     height: 45,
                                     child: ListTile(
                                       title: Text('Address1:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                       subtitle: Text(result[0].address,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                     ),
                                   ),
                                     SizedBox(
                                       height: 45,
                                       child: ListTile(
                                         title: Text('Address1:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                         subtitle: Text(result[0].address1,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                       ),
                                     ),
                                     SizedBox(
                                       height: 45,
                                       child: ListTile(
                                         title: Text('Country/State/City:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                         subtitle: Text(result[0].strcities.name+"-"+result[0].strstate.name+"-"+ result[0].strcountry.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                       ),
                                     ),
                                     SizedBox(
                                       height: 45,
                                       child: ListTile(
                                         title: Text('Zip/Pin:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                         subtitle: Text(result[0].strpin,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                       ),
                                     ),


                                 ],),
                               )
                             ),

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Contact Information",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                             ),
                             Card(
                                 color: Colors.grey,
                                 child: Padding(
                                   padding: const EdgeInsets.only(bottom: 15),
                                   child: Column(
                                     children: [
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Home Phone:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                           subtitle: Text(result[0].phone,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Mobile No:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].mob,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Email:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].email,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                     ],),
                                 )
                             ),

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Business Information",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                             ),
                             Card(
                                 color: Colors.grey,
                                 child: Padding(
                                     padding: const EdgeInsets.only(bottom: 15),
                                   child: Column(
                                     children: [
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Website:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                           subtitle: Text(result[0].bWebsite.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Type of Business:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].bDetail.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Location:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].bLocation.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                     ],),
                                 )
                             ),

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Family Details",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                             ),
                             Card(
                                 color: Colors.grey,
                                 child: Padding(
                                   padding: const EdgeInsets.only(bottom: 15),
                                   child: Column(
                                     children: [
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Parents:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                                           subtitle: Text(result[0].parent,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Spouse Parents:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].sParents,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Native:city/country:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].natCity,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Name of Samajik sanstha involved:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].sSanstha,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Extra1:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].ext1.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('Extra2:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].ext2,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                       SizedBox(
                                         height: 45,
                                         child: ListTile(
                                           title: Text('About Family:',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                           subtitle: Text(result[0].aboutFamily,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                         ),
                                       ),
                                     ],),
                                 )
                             ),

                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text("Family Information",style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),),
                             ),
                             Card(
                                 color: Colors.grey,
                                 child: Padding(
                                   padding: const EdgeInsets.only(bottom: 15),
                                   child: ListView.builder(
                                     shrinkWrap: true,
                                     physics: NeverScrollableScrollPhysics(),
                                     itemCount: result[0].familyinfo.length,
                                       itemBuilder: (context, index) {
                                         return Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.only(left: 8,top: 2),
                                               child: CircleAvatar(child: Text("#$index",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10)),radius: 10),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("Name:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("Relation:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].relation,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("Data of Birth:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].dob,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("occupation:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].occ.name,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("Phone:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].phone,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(
                                               height: 45,
                                               child: ListTile(
                                                 title: Text("Email:",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                                 subtitle: Text(result[0].familyinfo[index].email,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                               ),
                                             ),
                                             SizedBox(height: 3,),
                                             Divider(color: Colors.black),

                                           ],
                                         );
                                       },
                                   ),
                                 )
                             )

                           ],
                       ),
                     )
                   ],
                 ),
              ),
            ),
          )
          :null
    );
  }
}
