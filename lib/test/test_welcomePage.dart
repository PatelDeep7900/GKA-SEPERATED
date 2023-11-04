import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gka/models/homeModels/welcomejson.dart';
import 'package:http/http.dart' as http;
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class test_welcomepage extends StatefulWidget {
  const test_welcomepage({super.key});
  @override
  State<test_welcomepage> createState() => _test_welcomepageState();
}

class _test_welcomepageState extends State<test_welcomepage> {
  ScrollController scrollController = ScrollController();
  List<Results> result = [];
  List<Results> searchresult = [];
  int _page = 0;
  int _len = 0;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  bool _hashNextPage = true;
  bool _isLoadMoreRunning = false;

  int? aproveornot=0;
  bool _vbSearch=false;
int? id=0;


  void _firstLoad() async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();


    setState(() {
      _isFirstLoadRunning = true;
      id = prefs.getInt("id")!;
    });
    try {
      var url ="http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit&id=$id";
      var uri = Uri.parse(url);
      final response = await http.get(uri);
      setState(() {
        Welcome welcome = Welcome.fromJson(json.decode(response.body));
        result = result + welcome.results!;
        aproveornot=welcome.aproveornot;

        if(aproveornot==1){
          _vbSearch=true;
        }

      });
    } catch (err) {
        print(err.toString());
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _loadMore() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      id = prefs.getInt("id")!;
    });


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
            "http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit&id=$id";
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
      });
    } catch (err) {
      print(err.toString());
    }
  }

  _launchCaller(String number) async {
    final url = "tel:$number";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsapp(String number) async {
    var whatsapp = "+1$number";
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
          Visibility(
            visible: _vbSearch,
            child: Padding(
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
                          child: aproveornot==0 ? _aprrovenot(context) :  _len == 0
                              ? _datalist(context,result)
                              : _datalist(context,searchresult)
                      ),
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


 Widget _datalist(BuildContext context,List<Results> data){
    return   ListView.builder(
      controller: scrollController,
      itemCount: data.length,
      itemBuilder: (context, index) => Card(
        color: (index % 2 == 0)
            ? Colors.white
            : Colors.white60,
        key: ValueKey(data[index].id),
        shape: Border.all(color: Colors.grey),
        elevation: 8,
        child: InkWell(
          onTap: () {
            // result[index].id
          },
          child: ExpansionTile(
            leading: data[index].imgapprove == "P"
                ? const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                  'assets/images/underreview.png'),
            )
                : data[index].imgapprove == "N"
                ? const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                  "assets/images/nopic.png"),
            )
                : CircleAvatar(
              radius: 30,
              backgroundImage:
              NetworkImage(
                  data[index]
                      .img1
                      .toString()),
            ),
            title: Text(
              '${index + 1}',
            ),
            subtitle:
            Text(data[index].name.toString()),
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
                                    child:
                                    const Text(
                                      'Address1',
                                      style: TextStyle(
                                          fontSize:
                                          13),
                                    )),
                              ),
                              const DataCell(
                                  Text(":")),
                              DataCell(Text(
                                data[index]
                                    .address
                                    .toString(),
                                style:
                                const TextStyle(
                                    fontSize:
                                    13),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Address2',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              DataCell(Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .address1
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13))),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Country',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              DataCell(Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .strcountry
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13))),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'State',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .strstate
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13))),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'City',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .strcities
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13))),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Zip/Pin',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Text(
                                    data[index]
                                        .strpin
                                        .toString(),
                                    style:
                                    const TextStyle(
                                        fontSize:
                                        13)),
                              )),
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
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(
                                Container(
                                    width: 65,
                                    child:
                                    const Text(
                                      'Country Code',
                                      style: TextStyle(
                                          fontSize:
                                          13),
                                    )),
                              ),
                              const DataCell(
                                  Text(":")),
                              DataCell(Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: const Text(
                                  '+1',
                                  style: TextStyle(
                                      fontSize: 13),
                                ),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Home Phone',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Row(
                                children: [
                                  Text(
                                      data[index]
                                          .phone
                                          .toString(),
                                      style:
                                      const TextStyle(
                                          fontSize:
                                          13)),
                                  data[index]
                                      .phone ==
                                      "****"
                                      ? Container()
                                      : InkWell(
                                      child: const Icon(
                                          Icons
                                              .phone,
                                          color: Colors
                                              .blue,
                                          size:
                                          25),
                                      onTap: () {
                                        _launchCaller(data[
                                        index]
                                            .phone
                                            .toString());
                                      }),
                                ],
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Row(
                                children: [
                                  Text(
                                      data[index]
                                          .mob
                                          .toString(),
                                      style:
                                      const TextStyle(
                                          fontSize:
                                          13)),
                                  data[index].mob ==
                                      "****"
                                      ? Container()
                                      : Row(
                                    children: [
                                      InkWell(
                                          child: const Icon(
                                              Icons.phone,
                                              color: Colors.blue,
                                              size: 25),
                                          onTap: () {
                                            _launchCaller(data[index].mob.toString());
                                          }),
                                      const SizedBox(
                                        width:
                                        5,
                                      ),
                                      InkWell(
                                          child: Logo(
                                              Logos.whatsapp,
                                              size: 25),
                                          onTap: () {
                                            _launchWhatsapp(data[index].mob.toString());
                                          }),
                                    ],
                                  ),
                                ],
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Email',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Row(
                                children: [
                                  Text(
                                      data[index]
                                          .email
                                          .toString(),
                                      style:
                                      const TextStyle(
                                          fontSize:
                                          13)),
                                  data[index]
                                      .email ==
                                      "****"
                                      ? Container()
                                      : InkWell(
                                      child: const Icon(
                                          Icons
                                              .mail,
                                          color: Colors
                                              .blue,
                                          size:
                                          25),
                                      onTap: () {
                                        launch(
                                            'mailto:${data[index].email}');
                                      }),
                                ],
                              )),
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
                const Text("Business Details"),
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
                                    child:
                                    const Text(
                                      'Website',
                                      style: TextStyle(
                                          fontSize:
                                          13),
                                    )),
                              ),
                              const DataCell(
                                  Text(":")),
                              DataCell(Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Text(
                                  data[index]
                                      .bWebsite
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13),
                                ),
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Business Type',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .bDetail
                                      .toString(),
                                  style:
                                  const TextStyle(
                                      fontSize:
                                      13))),
                            ]),
                            DataRow(cells: [
                              DataCell(Container(
                                  width: 65,
                                  child: const Text(
                                      'Business Location',
                                      style: TextStyle(
                                          fontSize:
                                          13)))),
                              const DataCell(
                                  Text(":")),
                              DataCell(Text(
                                  data[index]
                                      .bLocation
                                      .toString(),
                                  style:
                                  const TextStyle(
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
              data[index].userApprov == "1"
                  ? ExpansionTile(
                title: const Text("Family"),
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount: data[index]
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
                                                child: const Text(
                                                  'name',
                                                  style: TextStyle(fontSize: 13),
                                                )),
                                          ),
                                          const DataCell(
                                              Text(":")),
                                          DataCell(
                                              Text(
                                                data[index]
                                                    .familyinfo![index1]
                                                    .name
                                                    .toString(),
                                                style:
                                                const TextStyle(fontSize: 13),
                                              )),
                                        ]),
                                    DataRow(
                                        cells: [
                                          DataCell(Container(
                                              width:
                                              72,
                                              child:
                                              const Text('Date Of Birth', style: TextStyle(fontSize: 13)))),
                                          const DataCell(
                                              Text(":")),
                                          DataCell(Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            child: Text(
                                                data[index].familyinfo![index1].dob.toString(),
                                                style: const TextStyle(fontSize: 13)),
                                          )),
                                        ]),
                                    DataRow(
                                        cells: [
                                          DataCell(Container(
                                              width:
                                              72,
                                              child:
                                              const Text('occupation', style: TextStyle(fontSize: 13)))),
                                          const DataCell(
                                              Text(":")),
                                          DataCell(Text(
                                              data[index].familyinfo![index1].occ.toString(),
                                              style: const TextStyle(fontSize: 13))),
                                        ]),
                                    DataRow(
                                        cells: [
                                          DataCell(Container(
                                              width:
                                              72,
                                              child:
                                              const Text('Phone', style: TextStyle(fontSize: 13)))),
                                          const DataCell(
                                              Text(":")),
                                          DataCell(Text(
                                              data[index].familyinfo![index1].phone.toString(),
                                              style: const TextStyle(fontSize: 13))),
                                        ]),
                                    DataRow(
                                        cells: [
                                          DataCell(Container(
                                              width:
                                              72,
                                              child:
                                              const Text('Email', style: TextStyle(fontSize: 13)))),
                                          const DataCell(
                                              Text(":")),
                                          DataCell(Text(
                                              data[index].familyinfo![index1].email.toString(),
                                              style: const TextStyle(fontSize: 13))),
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
    );
 }


 Widget _aprrovenot(BuildContext context){

    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("You Are Under Approval Mode!",style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
            Divider(),
            SizedBox(height: 10,),
            Text('Welcome to GKA USA & CANADA',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
            SizedBox(height: 5,),
            Text.rich(
              TextSpan(
                text: 'Gujarati Kshatriya Associationwas founded in 1989. The goal of our Non-Profit organization is to unite and serve all our Gujarati Kshatriya communities living in USA-CANADA and to promote and preserve our heritage and language, and bring cultural awareness to future generations by providing a platform to all our community families while serving the community needs.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 12,),
            Text.rich(
              TextSpan(
                text: 'The charitable and social activities developed steadily through the past 30+ years and the group cohesiveness of our past and present executive committee members and Board of Trustees along with many volunteers have culminated in a strong and vibrant Gujarati Kshatriya Association. As we continue our progress in 21st century, the foundation of social adaptiveness set forth by our previous executive committee members, has strengthen our resolve and made us proud of our cultural heritage.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 12,),
            Text.rich(
              TextSpan(
                text: 'We have very active Mandals like GKA South East Atlanta, Vancouver Mochi Gnati Mandal, GKSNA NY/NJ and Mochi Gnati Mandal of Ontario-Canada where they regularly celebrate Diwali-Mela and picnic during the year. With the help of every Gujarati Kshatriya Association member in our community, we encourage each and every family to participate in cultural and social activities to build our strong youth generation.',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
 }

}
