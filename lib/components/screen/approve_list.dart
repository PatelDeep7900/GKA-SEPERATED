import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/approved_model.dart';

class ApproveList extends StatefulWidget {
  const ApproveList({super.key});

  @override
  State<ApproveList> createState() => _ApproveListState();
}

class _ApproveListState extends State<ApproveList> {
  @override
  void initState() {
    _approvelists();
    super.initState();
  }

  List<Data> result = [];
  bool _datafound=false;


  void _approvelists() async {
    try {
      var url = "http://e-gam.com/GKARESTAPI/c_userapprove";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if(response.statusCode==200){
       approved apr = approved.fromJson(json.decode(response.body));
       setState(() {
         result=apr.data!;
         _datafound=apr.datafound!;
       });

      }

    } catch (err) {
      print(err.toString());
    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount:result.length,
        itemBuilder: (context, index) {
          return Card(
            child: ExpansionTile(
              title: Text('${index+1}'),
              subtitle: Text('${result[index].name}'),
               expandedAlignment: Alignment.topLeft,
               children: [
                 Chip(label: Text('${result[index].email}')),
                 SizedBox(height: 10,),
                 Divider(),
                 Text('Two Images',style: TextStyle(fontWeight: FontWeight.bold)),
                 SizedBox(height: 10,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       height: 100,
                       width: 100,
                       color: Colors.blue,
                       child: Center(child: Text('image1',)),
                     ),
                     SizedBox(width: 10,),
                     Container(
                       height: 100,
                       width: 100,
                       color: Colors.red,
                       child: Center(child: Text('image2')),
                     )
                   ],
                 ),
                 SizedBox(height: 10,),
                 Divider(),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Expanded(
                       child: ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(Colors.green),
                         ),
                           onPressed: () {
                       }, child: Text('Aprove')),
                     ),
                     SizedBox(width: 10,),
                     Expanded(
                       child: ElevatedButton(
                         style:  ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.red),
          ),
                           onPressed: () {
                       }, child: Text('Reject')),
                     ),
                   ],
                 ),
                 SizedBox(height: 10,),
                 Container(
                   color: Colors.black12,
                   child: const ExpansionTile(
                     title: Text('information'),
                     children: [
                       ExpansionTile(
                         title: const Text("Basic Information"),
                         children: [
                           Card(
                             child: Row(
                               children: [
                                 const Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Address1'),
                                     Text('Address2'),
                                     Text('Country'),
                                     Text('State'),
                                     Text('City'),
                                     Text('Zip/Pin'),
                                   ],
                                 ),
                                 const SizedBox(width: 5,),
                                 const Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(':'),
                                     Text(':'),
                                     Text(':'),
                                     Text(':'),
                                     Text(':'),
                                     Text(':'),
                                   ],
                                 ),
                                 const SizedBox(width: 15,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('result[index].address.toString()'),
                                     Text('result[index].address1.toString()'),
                                     Text('result[index].strcountry.toString()'),
                                     Text('result[index].strstate.toString()'),
                                     Text('result[index].strcities.toString()'),
                                     Text('result[index].strpin.toString()'),
                                   ],
                                 ),
                               ],
                             ),
                           )
                         ],
                       ),
                     ],
                   ),
                 )
               ],
            ),
          );
      },),
    );
  }
}
