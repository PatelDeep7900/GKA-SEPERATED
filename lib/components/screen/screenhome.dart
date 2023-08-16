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
        "http://e-gam.com/GKARESTAPI/welcomePage?off=$paraoffset&lim=10";
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
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                        "http://e-gam.com/GKA/Logo/GKA%20logo.jpg"),
                  ),
                  title: Text(
                    '${index + 1}',
                  ),
                  subtitle: Text(result[index].name),
                  children: [
                    ExpansionTile(
                      title: const Text("Basic Information"),
                      children: [
                        Card(
                          child: Column(
                          children: [
                            Row(
                              children: [
                                const Text('Address1'),
                                Expanded(child: Text(result[index].address)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Address2'),
                                Expanded(child: Text(result[index].address1)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Country'),
                                Expanded(child: Text(result[index].strcountry.name)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('State'),
                                Expanded(child: Text(result[index].strstate.name)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('City'),
                                Expanded(child: Text(result[index].strcities.name)),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Zip/Pin'),
                                Expanded(child: Text(result[index].strpin)),
                              ],
                            ),

                          ],
                        ),)
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("Contact Information"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              const Row(
                                children: [
                                  Text('Country Code'),
                                  Expanded(child: Text("+1")),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Home Phone'),
                                  Expanded(child: Text(result[index].phone)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Mobile'),
                                  Expanded(child: Text(result[index].mob)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Email'),
                                  Expanded(child: Text(result[index].email)),
                                ],
                              ),

                            ],
                          ),)
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("Businees Details"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Website'),
                                  Expanded(child: Text(result[index].bWebsite.name)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Type of Businees'),
                                  Expanded(child: Text(result[index].bDetail.name)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Location'),
                                  Expanded(child: Text(result[index].bLocation.name)),
                                ],
                              ),
                            ],
                          ),)
                      ],
                    ),
                    ExpansionTile(
                      title: const Text("Family Details"),
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text('Parents'),
                                  Expanded(child: Text(result[index].parent)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Spouse Parents'),
                                  Expanded(child: Text(result[index].sParents)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Native:City/Country'),
                                  Expanded(child: Text(result[index].natCity)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Name of Samajik Sanstha Involved'),
                                  Expanded(child: Text(result[index].sSanstha)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Extra1'),
                                  Expanded(child: Text(result[index].ext1.name)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('Extra2'),
                                  Expanded(child: Text(result[index].ext2)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('About Family'),
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
              duration: const Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,
        tooltip: "Scroll to Bottom",
        child: const Icon(Icons.arrow_circle_up),
      ),
    );
  }
}
