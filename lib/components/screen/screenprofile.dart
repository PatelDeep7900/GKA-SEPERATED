import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gka/models/welcomejson.dart';

class profilescreen extends StatefulWidget {
  const profilescreen({super.key});

  @override
  State<profilescreen> createState() => _profilescreenState();
}

class _profilescreenState extends State<profilescreen> {
  bool _isloading = false;
  bool? _cimgpathexists1=false;
  String? _img1="";
  List<Results> result = [];
  bool _isEdit = false;
  TextEditingController inoutcint = TextEditingController(text: 'Hello');
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
      _cimgpathexists1=prefs.getBool("cimgpathexists1");
      _img1=prefs.getString("img1");
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
                            child: _cimgpathexists1==true ? CircleAvatar(radius: 80,backgroundImage: NetworkImage(_img1!),) :Image.asset("assets/images/nopic.png"),
                            backgroundColor: Colors.black,
                            radius: 80,
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
                                            DataCell( Container(width:65,child: Text('Address1',style: TextStyle(fontSize: 13),)),),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].address.toString(),style: TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Address2',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].address1.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Country',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].strcountry.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('State',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].strstate.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('City',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].strcities.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Zip/Pin',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].strpin.toString(),style: TextStyle(fontSize: 13))),
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
                                            DataCell( Container(width:65,child: Text('Country Code',style: TextStyle(fontSize: 13),)),),
                                            DataCell(Text(":")),
                                            DataCell(Text('+1',style: TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Home Phone',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].phone.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Mobile',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].mob.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Email',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].email.toString(),style: TextStyle(fontSize: 13))),
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
                                            DataCell( Container(width:65,child: Text('Website',style: TextStyle(fontSize: 13),)),),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].bWebsite.toString(),style: TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Business Type',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].bDetail.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Business Location',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].bLocation.toString(),style: TextStyle(fontSize: 13))),
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
                                            DataCell( Container(width:65,child: Text('Parents',style: TextStyle(fontSize: 13),)),),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].parent.toString().toString(),style: TextStyle(fontSize: 13),)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Spouse Parents',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].sParents.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Native:city/country',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].natCity.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Samajik sanstha',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].sSanstha.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Extra1',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].ext1.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('Extra2',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].ext2.toString(),style: TextStyle(fontSize: 13))),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Container(width:65,child: Text('About Family',style: TextStyle(fontSize: 13)))),
                                            DataCell(Text(":")),
                                            DataCell(Text(result[0].aboutFamily.toString(),style: TextStyle(fontSize: 13))),
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
                                                    DataCell( Container(width:72,child: Text('name',style: TextStyle(fontSize: 13),)),),
                                                    DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].name.toString(),style: TextStyle(fontSize: 13),)),
                                                  ]),

                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: Text('Date Of Birth',style: TextStyle(fontSize: 13)))),
                                                    DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].dob.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: Text('occupation',style: TextStyle(fontSize: 13)))),
                                                    DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].occ.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: Text('Phone',style: TextStyle(fontSize: 13)))),
                                                    DataCell(Text(":")),
                                                    DataCell(Text(result[0].familyinfo![index].phone.toString(),style: TextStyle(fontSize: 13))),
                                                  ]),
                                                  DataRow(cells: [
                                                    DataCell(Container(width:72,child: Text('Email',style: TextStyle(fontSize: 13)))),
                                                    DataCell(Text(":")),
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
