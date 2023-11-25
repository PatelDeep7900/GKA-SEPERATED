import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gka/models/homeModels/welcomejson.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  List<Results> result = [];
  bool _isloading = false;
  String? _img1="";
  int id = 0;

  Future<void> profiledata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getInt("id")!;
    setState(() {
      _isloading = true;
    });
    var uri = "http://e-gam.com/GKARESTAPI/searchbyid?id=$id";
    print(uri);
    final url = Uri.parse(uri);
    final response = await http.get(url);
    setState(() {
      Welcome welcome = Welcome.fromJson(json.decode(response.body));
      result = welcome.results!;
      _img1=result[0].img1;
    });
    setState(() {
      _isloading = false;
    });
  }

  @override
  void initState() {
    profiledata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : result.isNotEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 80,
                            child:  CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(_img1!),

                            ) ,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Basic Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment:  Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: DataTable(
                                        columnSpacing: 20.0,
                                        headingRowHeight: 0,
                                        columns: [
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell( Container(width:65,child: const Text('Address1',style: TextStyle(fontSize: 13),)),),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].address.toString(),style: const TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Address2',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].address1.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Country',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].strcountry.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('State',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].strstate.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('City',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].strcities.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Zip/Pin',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Container(width: MediaQuery.of(context).size.width*0.6,child: Text(result[0].strpin.toString(),style: TextStyle(fontSize: 13)))),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Contact Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment:  Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: DataTable(
                                        columnSpacing: 20.0,
                                        headingRowHeight: 0,
                                        columns: [
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell( Container(width:65,child: const Text('Country Code',style: TextStyle(fontSize: 13),)),),
                                            const DataCell(Text(":")),
                                            DataCell(Container(width:MediaQuery.of(context).size.width*0.6,child: Text('+1',style: TextStyle(fontSize: 13),))),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Home Phone',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].phone.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Mobile',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].mob.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Email',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].email.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Business Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: DataTable(
                                        columnSpacing: 20.0,
                                        headingRowHeight: 0,
                                        columns: [
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell( Container(width:65,child: const Text('Website',style: TextStyle(fontSize: 13),)),),
                                            const DataCell(Text(":")),
                                            DataCell(Container(width:MediaQuery.of(context).size.width*0.6,child: Text(result[0].bWebsite.toString(),style: TextStyle(fontSize: 13),))),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Business Type',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].bDetail.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Business Location',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].bLocation.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Family Details",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment:  Alignment.topLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      child: DataTable(
                                        columnSpacing: 20.0,
                                        headingRowHeight: 0,
                                        columns: [
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                          DataColumn(label: Container()),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell( Container(width:65,child: const Text('Parents',style: TextStyle(fontSize: 13),)),),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].parent.toString().toString(),style: const TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Spouse Parents',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].sParents.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Native:city/country',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Container(width:MediaQuery.of(context).size.width*0.6,child: Text(result[0].natCity.toString(),style: TextStyle(fontSize: 13)))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Samajik sanstha',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].sSanstha.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Extra1',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].ext1.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('Extra2',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].ext2.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: const Text('About Family',style: TextStyle(fontSize: 13)))),
                                            const DataCell(Text(":")),
                                            DataCell(Text(result[0].aboutFamily.toString(),style: const TextStyle(fontSize: 13))),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Family Information",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: result[0].familyinfo!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: Container(
                                          alignment:  Alignment.topLeft,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              child: DataTable(
                                                columnSpacing: 20.0,
                                                headingRowHeight: 0,
                                                columns: [
                                                  DataColumn(label: Container()),
                                                  DataColumn(label: Container()),
                                                  DataColumn(label: Container()),
                                                ],
                                                rows: [
                                                  DataRow(cells: [
                                                    DataCell( Container(width:72,child: const Text('name',style: TextStyle(fontSize: 13),)),),
                                                    const DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].name.toString(),style: TextStyle(fontSize: 13),)),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell( Container(width:72,child: const Text('Relation',style: TextStyle(fontSize: 13),)),),
                                                    const DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].relation.toString(),style: TextStyle(fontSize: 13),)),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: const Text('Date Of Birth',style: TextStyle(fontSize: 13)))),
                                                    const DataCell(Text(":")),
                                                    DataCell(Container(width:MediaQuery.of(context).size.width*0.6,child: Text(result[0].familyinfo![index].dob.toString(),style: TextStyle(fontSize: 13)))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: const Text('occupation',style: TextStyle(fontSize: 13)))),
                                                    const DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].occ.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: const Text('Phone',style: TextStyle(fontSize: 13)))),
                                                    const DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].phone.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: const Text('Email',style: TextStyle(fontSize: 13)))),
                                                    const DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].email.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : null);
  }
}
