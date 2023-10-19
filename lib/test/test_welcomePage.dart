import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gka/models/welcomejson.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class test_welcomepage extends StatefulWidget {
  const test_welcomepage({super.key});

  @override
  State<test_welcomepage> createState() => _test_welcomepageState();
}

class _test_welcomepageState extends State<test_welcomepage> {
  ScrollController scrollController = ScrollController();

  int _page = 0;
  int _len = 0;
  String _searchval = "";

  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  List<Results> result = [];

  List<Results> searchresult = [];

  bool _hashNextPage = true;
  bool _isLoadMoreRunning = false;

  void _search(String searchval) async {
    setState(() {
      _hashNextPage = true;
    });

    try {
      var url = "http://e-gam.com/GKARESTAPI/serchbyname?nm=$searchval";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      setState(() {
        Welcome welcome = Welcome.fromJson(json.decode(response.body));
        searchresult = welcome.results!;
        bool? wp = welcome.datafound;
      });
    } catch (err) {
      print(err.toString());
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      var url =
          "http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit";
      print(url);
      var uri = Uri.parse(url);

      final response = await http.get(uri);
      setState(() {
        Welcome welcome = Welcome.fromJson(json.decode(response.body));
        result = result + welcome.results!;
      });
    } catch (err) {
      print(err.toString());
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    if (_hashNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        scrollController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      setState(() {
        _page = _page + _limit;
      });

      try {
        var url =
            "http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit";
        var uri = Uri.parse(url);

        final response = await http.get(uri);

        var a = jsonDecode(response.body);
        if (a['datafound'] == true) {
          Welcome welcome = Welcome.fromJson(json.decode(response.body));
          if (result.isNotEmpty) {
            setState(() {
              result = result + welcome.results!;
            });
          }
        } else {
          setState(() {
            _hashNextPage = false;
          });
        }
      } catch (err) {
        print(err.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _hashNextPage = true;
                  searchresult = [];
                });
                if (value.length > 2) {
                  setState(() {
                    _len = value.length;
                    _search(value);
                  });
                }
                setState(() {
                  _len = value.length;
                  if (_len == 0) {
                    _hashNextPage = true;
                  }
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
          ),
          _isFirstLoadRunning
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          child: _len == 0
                              ? ListView.builder(
                                  controller: scrollController,
                                  itemCount: result.length,
                                  itemBuilder: (context, index) => Card(
                                    color: (index % 2 == 0)
                                        ? Colors.white
                                        : Colors.white60,
                                    key: ValueKey(result[index].id),
                                    shape: Border.all(color: Colors.grey),
                                    elevation: 8,
                                    child: InkWell(
                                      onTap: () {
                                        // result[index].id
                                      },
                                      child: ExpansionTile(
                                        leading: result[index]
                                                    .cimgpathexists1 ==
                                                true
                                            ? CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    result[index]
                                                        .img1
                                                        .toString()),
                                              )
                                            : result[index].imgapprove == "P"
                                                ? CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/underreview.png'),
                                                  )
                                                : result[index].imgapprove ==
                                                        "C"
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            'assets/images/canceled.png'),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/nopic.png"),
                                                      ),
                                        title: Text(
                                          '${index + 1}',
                                        ),
                                        subtitle:
                                            Text(result[index].name.toString()),
                                        children: [
                                          ExpansionTile(
                                            title:
                                                const Text("Basic Information"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Address1',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            result[index]
                                                                .address
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Address2',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .address1
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Country',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .strcountry
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'State',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .strstate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'City',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .strcities
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Zip/Pin',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .strpin
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: const Text(
                                                "Contact Information"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container())
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Country Code',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            '+1',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                          DataCell(Text(
                                                            '',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Home Phone',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .phone
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            result[index]
                                                                        .phone ==
                                                                    "****"
                                                                ? Container()
                                                                : InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .phone,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25),
                                                                    onTap: () {
                                                                      _launchCaller(result[
                                                                              index]
                                                                          .phone
                                                                          .toString());
                                                                    }),
                                                          ),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Mobile',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .mob
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            result[index].mob ==
                                                                    "****"
                                                                ? Container()
                                                                : Row(
                                                                    children: [
                                                                      InkWell(
                                                                          child: Icon(
                                                                              Icons.phone,
                                                                              color: Colors.blue,
                                                                              size: 25),
                                                                          onTap: () {
                                                                            _launchCaller(result[index].mob.toString());
                                                                          }),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      InkWell(
                                                                          child: Logo(
                                                                              Logos.whatsapp,
                                                                              size: 25),
                                                                          onTap: () {
                                                                            _launchWhatsapp(result[index].mob.toString());
                                                                          }),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .email
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            result[index]
                                                                        .email ==
                                                                    "****"
                                                                ? Container()
                                                                : InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .mail,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25),
                                                                    onTap: () {
                                                                      launch(
                                                                          'mailto:${result[index].email}');
                                                                    }),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            title:
                                                const Text("Businees Details"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Website',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            result[index]
                                                                .bWebsite
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Business Type',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .bDetail
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Business Location',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              result[index]
                                                                  .bLocation
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          result[index].userApprov == "1"
                                              ? ExpansionTile(
                                                  title: const Text("Family"),
                                                  children: [
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: result[index]
                                                          .familyinfo!
                                                          .length,
                                                      itemBuilder:
                                                          (context, index1) =>
                                                              Card(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: DataTable(
                                                                columnSpacing:
                                                                    20.0,
                                                                headingRowHeight:
                                                                    0,
                                                                columns: [
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                ],
                                                                rows: [
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(
                                                                          Container(
                                                                              width: 72,
                                                                              child: Text(
                                                                                'name',
                                                                                style: TextStyle(fontSize: 13),
                                                                              )),
                                                                        ),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(
                                                                            Text(
                                                                          result[index]
                                                                              .familyinfo![index1]
                                                                              .name
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 13),
                                                                        )),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Date Of Birth', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            result[index].familyinfo![index1].dob.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('occupation', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            result[index].familyinfo![index1].occ.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Phone', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            result[index].familyinfo![index1].phone.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Email', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            result[index].familyinfo![index1].email.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const Text(""),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  // controller: scrollController,
                                  itemCount: searchresult.length,
                                  itemBuilder: (context, index) => Card(
                                    key: ValueKey(searchresult[index].id),
                                    shape: Border.all(color: Colors.grey),
                                    elevation: 8,
                                    child: InkWell(
                                      onTap: () {
                                        // result[index].id
                                      },
                                      child: ExpansionTile(
                                        leading: searchresult[index]
                                                    .cimgpathexists1 ==
                                                true
                                            ? CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    searchresult[index]
                                                        .img1
                                                        .toString()),
                                              )
                                            : searchresult[index].imgapprove ==
                                                    "P"
                                                ? CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/underreview.png'),
                                                  )
                                                : searchresult[index]
                                                            .imgapprove ==
                                                        "C"
                                                    ? CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            'assets/images/canceled.png'),
                                                      )
                                                    : CircleAvatar(
                                                        radius: 30,
                                                        backgroundImage: AssetImage(
                                                            "assets/images/nopic.png"),
                                                      ),
                                        title: Text(
                                          '${index + 1}',
                                        ),
                                        subtitle: Text(searchresult[index]
                                            .name
                                            .toString()),
                                        children: [
                                          ExpansionTile(
                                            title:
                                                const Text("Basic Information"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Address1',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            searchresult[index]
                                                                .address
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Address2',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .address1
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Country',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .strcountry
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'State',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .strstate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'City',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .strcities
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Zip/Pin',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .strpin
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            title: const Text(
                                                "Contact Information"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container())
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Country Code',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            '+1',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                          DataCell(Text(
                                                            '',
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Home Phone',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .phone
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            searchresult[index]
                                                                        .phone ==
                                                                    "****"
                                                                ? Container()
                                                                : InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .phone,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25),
                                                                    onTap: () {
                                                                      _launchCaller(searchresult[
                                                                              index]
                                                                          .phone
                                                                          .toString());
                                                                    }),
                                                          ),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Mobile',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .mob
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            searchresult[index]
                                                                        .mob ==
                                                                    "****"
                                                                ? Container()
                                                                : Row(
                                                                    children: [
                                                                      InkWell(
                                                                          child: Icon(
                                                                              Icons.phone,
                                                                              color: Colors.blue,
                                                                              size: 25),
                                                                          onTap: () {
                                                                            _launchCaller(searchresult[index].mob.toString());
                                                                          }),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      InkWell(
                                                                          child: Logo(
                                                                              Logos.whatsapp,
                                                                              size: 25),
                                                                          onTap: () {
                                                                            _launchWhatsapp(searchresult[index].mob.toString());
                                                                          }),
                                                                    ],
                                                                  ),
                                                          ),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Email',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .email
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                          DataCell(
                                                            searchresult[index]
                                                                        .email ==
                                                                    "****"
                                                                ? Container()
                                                                : InkWell(
                                                                    child: Icon(
                                                                        Icons
                                                                            .mail,
                                                                        color: Colors
                                                                            .blue,
                                                                        size:
                                                                            25),
                                                                    onTap: () {
                                                                      launch(
                                                                          'mailto:${searchresult[index].email}');
                                                                    }),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          ExpansionTile(
                                            title:
                                                const Text("Businees Details"),
                                            children: [
                                              Container(
                                                alignment: Alignment.topLeft,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: DataTable(
                                                      columnSpacing: 20.0,
                                                      headingRowHeight: 0,
                                                      columns: [
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                        DataColumn(
                                                            label: Container()),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(
                                                            Container(
                                                                width: 65,
                                                                child: Text(
                                                                  'Website',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13),
                                                                )),
                                                          ),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                            searchresult[index]
                                                                .bWebsite
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 13),
                                                          )),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Business Type',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .bDetail
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                        DataRow(cells: [
                                                          DataCell(Container(
                                                              width: 65,
                                                              child: Text(
                                                                  'Business Location',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          13)))),
                                                          DataCell(Text(":")),
                                                          DataCell(Text(
                                                              searchresult[
                                                                      index]
                                                                  .bLocation
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13))),
                                                        ]),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          searchresult[index].userApprov == "1"
                                              ? ExpansionTile(
                                                  title: const Text("Family"),
                                                  children: [
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          searchresult[index]
                                                              .familyinfo!
                                                              .length,
                                                      itemBuilder:
                                                          (context, index1) =>
                                                              Card(
                                                        child: Container(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: DataTable(
                                                                columnSpacing:
                                                                    20.0,
                                                                headingRowHeight:
                                                                    0,
                                                                columns: [
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                  DataColumn(
                                                                      label:
                                                                          Container()),
                                                                ],
                                                                rows: [
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(
                                                                          Container(
                                                                              width: 72,
                                                                              child: Text(
                                                                                'name',
                                                                                style: TextStyle(fontSize: 13),
                                                                              )),
                                                                        ),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(
                                                                            Text(
                                                                          searchresult[index]
                                                                              .familyinfo![index1]
                                                                              .name
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(fontSize: 13),
                                                                        )),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Date Of Birth', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            searchresult[index].familyinfo![index1].dob.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('occupation', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            searchresult[index].familyinfo![index1].occ.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Phone', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            searchresult[index].familyinfo![index1].phone.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                  DataRow(
                                                                      cells: [
                                                                        DataCell(Container(
                                                                            width:
                                                                                72,
                                                                            child:
                                                                                Text('Email', style: TextStyle(fontSize: 13)))),
                                                                        DataCell(
                                                                            Text(":")),
                                                                        DataCell(Text(
                                                                            searchresult[index].familyinfo![index1].email.toString(),
                                                                            style: TextStyle(fontSize: 13))),
                                                                      ]),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const Text(""),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      if (_isLoadMoreRunning == true)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                      if (_hashNextPage == false)
                        Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          color: Colors.amber,
                          child: const Center(
                            child: Text("All Record Fatched SuccessFully"),
                          ),
                        )
                    ],
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xd9fd6d0c),
        onPressed: () {
          if (scrollController.hasClients) {
            final position = scrollController.position.minScrollExtent;
            scrollController.animateTo(
              position,
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }

  _launchCaller(String number) async {
    final url = "tel:${number}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsapp(String number) async {
    var whatsapp = "+1${number}";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=hello");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }
}
