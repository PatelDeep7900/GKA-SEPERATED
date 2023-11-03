import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/homeModels/approved_model.dart';

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
      var url = "http://192.168.10.141:8084/GKARESTAPI/c_userapprove";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      if(response.statusCode==200){
        approved apr = approved.fromJson(json.decode(response.body));
        setState(() {
          result=apr.data!;
          _datafound=apr.datafound!;
        });

        print(result.length);

      }

    } catch (err) {
      print(err.toString());
    }


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: DataTable(
              dataRowHeight: 100,
              showCheckboxColumn: true,


              columns: [
                DataColumn(label: Text('id')),
                DataColumn(label: Text('name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Image1')),
                DataColumn(label: Text('Image2')),
              ],
              rows: List.generate(result.length, (index) {
                final y = "${index+1}";
                final x = result[index].name;
                final z = result[index].email;
                final w = "assets/images/nopic.png";

                return DataRow(
                    selected: false,
                    onSelectChanged: (value) {
                      setState(() {

                      });
                    },
                    cells: [
                      DataCell(Container(child: Text(y))),
                      DataCell(Container(child: Text(x!))),
                      DataCell(Container(child: Text(z!))),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(height: 100,child: Image.asset(w),width: 100,),
                      )),
                      DataCell(Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(height: 100,child: Image.asset(w),width: 100),
                      )),
                    ]
                );
              }),
            ),
          ),
        )

    );
  }
}
