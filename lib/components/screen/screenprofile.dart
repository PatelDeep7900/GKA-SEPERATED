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

      Container(
        width: double.infinity,
        child: Column(
          children: [
            DataTable(
                columns: [
                 DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
                  DataColumn(label: Text('')),
        ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('lable')),
                    DataCell(Text(':')),
                    DataCell(Text('name')),
                  ]
                  )
                ]
            ),
          ],
        ),
      )


          :null
    );
  }
}
