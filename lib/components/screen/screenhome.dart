import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gka/models/welcomejson.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen>{
  List<Result> result = [];
  bool loading = false;
  int off =0;
  bool visiblebtn = true;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchData(off);
    handleNext();
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        setState(() {
          loading = true;
        });
        fetchData(off);
      }
    });
  }

  Future<void> fetchData(paraoffset) async {

    var url =
        "http://e-gam.com/GKARESTAPI/welcomePage?off=${paraoffset}&lim=10";
    print(url);
    var uri = Uri.parse(url);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      Welcome welcome = Welcome.fromJson(json.decode(response.body));
      result = result + welcome.results;
      int localOffset = off + 25;
      setState(() {
        result;
        loading = false;
        off = localOffset;
      });
    }else{
      print("error===============huhuj");
    }
  }

  var status = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: scrollController,
        itemCount: loading ? result.length + 1 : result.length,
        itemBuilder: (context, index) {
          if (index < result.length) {
            return Card(
              shape: Border.all(color: Colors.grey),
              elevation: 8,
              child: InkWell(
                onTap: () {

                  // result[index].id
                },
                child: ExpansionTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "http://e-gam.com/GKA/Logo/GKA%20logo.jpg"),
                  ),
                  title: Text(
                    '${index + 1}',
                  ),
                  subtitle: Text(result[index].name.toString()),
                  children: [
                    ExpansionTile(
                      title: Text("Basic Information"),
                      children: [
                        Card(
                          child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Address1'),
                                Expanded(child: Text(result[index].address)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Address2'),
                                Expanded(child: Text(result[index].address1)),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Country'),
                                Expanded(child: Text(result[index].strcountry.toString())),
                              ],
                            ),
                            Row(
                              children: [
                                Text('State'),
                                Expanded(child: Text(result[index].strstate.toString())),
                              ],
                            ),
                            Row(
                              children: [
                                Text('City'),
                                Expanded(child: Text(result[index].strcities.toString())),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Zip/Pin'),
                                Expanded(child: Text(result[index].strpin)),
                              ],
                            ),

                          ],
                        ),)
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Contact Information"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Country Code'),
                                  Expanded(child: Text("+1")),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Home Phone'),
                                  Expanded(child: Text(result[index].phone)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Mobile'),
                                  Expanded(child: Text(result[index].mob)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Email'),
                                  Expanded(child: Text(result[index].email)),
                                ],
                              ),

                            ],
                          ),)
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Businees Details"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Website'),
                                  Expanded(child: Text(result[index].bWebsite.toString())),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Type of Businees'),
                                  Expanded(child: Text(result[index].bDetail.toString())),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Location'),
                                  Expanded(child: Text(result[index].bLocation.toString())),
                                ],
                              ),
                            ],
                          ),)
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Family Details"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('Parents'),
                                  Expanded(child: Text(result[index].parent)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Spouse Parents'),
                                  Expanded(child: Text(result[index].sParents)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Native:City/Country'),
                                  Expanded(child: Text(result[index].natCity.toString())),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Name of Samajik Sanstha Involved'),
                                  Expanded(child: Text(result[index].sSanstha)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Extra1'),
                                  Expanded(child: Text(result[index].ext1.toString())),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('Extra2'),
                                  Expanded(child: Text(result[index].ext2)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('About Family'),
                                  Expanded(child: Text(result[index].aboutFamily)),
                                ],
                              ),

                            ],
                          ),)
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (scrollController.hasClients) {
            final position = scrollController.position.minScrollExtent;
            scrollController.animateTo(
              position,
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: Icon(Icons.arrow_circle_up),
      ),
    );
  }
}
