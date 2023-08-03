import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gka/models/welcomejson.dart';
import 'package:http/http.dart' as http;

class test_welcomepage extends StatefulWidget {
  const test_welcomepage({super.key});

  @override
  State<test_welcomepage> createState() => _test_welcomepageState();
}

class _test_welcomepageState extends State<test_welcomepage> {
  ScrollController scrollController = ScrollController();


  var _baseUrl = "http://e-gam.com/GKARESTAPI/welcomePage";
  int _page = 0;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  List<Result> result = [];



  List<Result> searchresult = [];

  bool _hashNextPage=true;
  bool _isLoadMoreRunning=false;






  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    try {
      var url =
          "http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit";
      var uri = Uri.parse(url);
      print(url+"base");

      final response = await http.get(uri);
      setState(() {

        Welcome welcome = Welcome.fromJson(json.decode(response.body));
        result = result + welcome.results;



      });
    } catch (err) {
     print(err.toString());
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }



  void _loadMore()async {
    if (_hashNextPage == true
        && _isFirstLoadRunning == false
        && _isLoadMoreRunning == false
        && scrollController.position.extentAfter<300
    ) {
      setState(() {
        _isLoadMoreRunning = true;
      });


      setState(() {
        _page=_page+_limit;
      });

      try {
        var url =
            "http://e-gam.com/GKARESTAPI/welcomePage?off=$_page&lim=$_limit";
        var uri = Uri.parse(url);
        print(url+"scrool Url");


        final response = await http.get(uri);
        setState(() {
          Welcome welcome = Welcome.fromJson(json.decode(response.body));
          if(result.isNotEmpty) {
            setState(() {
              result = result + welcome.results;
            });
          }else{
            _hashNextPage=false;
          }


        });
      } catch (err) {
        setState(() {
          _hashNextPage=false;
        });
        print(err.toString());
      }



      setState(() {
        _isLoadMoreRunning = false;
      });

    }else{
      print("le lode");
    }
  }

  @override
  void initState() {
    super.initState();
    _firstLoad();
    scrollController=ScrollController()..addListener(_loadMore);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isFirstLoadRunning
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Expanded(child: ListView.builder(
                    controller: scrollController,
                      itemCount:result.length,
                      itemBuilder:(context, index) =>
             Card(
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
                          Expanded(child: Text(result[index].country.toString())),
                        ],
                      ),
                      Row(
                        children: [
                          Text('State'),
                          Expanded(child: Text(result[index].state.toString())),
                        ],
                      ),
                      Row(
                        children: [
                          Text('City'),
                          Expanded(child: Text(result[index].cities.toString())),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Zip/Pin'),
                          Expanded(child: Text(result[index].pin)),
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

            result[index].userApprov=="1" ?
            ExpansionTile(

              title: Text("Family Details"),
              children: [
               ListView.builder(
                 shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                    itemCount: result[index].familyinfo.length,
                    itemBuilder: (context, index1) =>
                        Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('#'),
                                  Expanded(child: Text("${index1+1}")),
                                ],
                              ),

                              Row(
                                children: [
                                  Text('name'),
                                  Expanded(child: Text(result[index].familyinfo[index1].name)),
                                ],
                              ),
                              Row(
                                children: [
                                  Text('dob'),
                                  Expanded(child: Text(result[index].familyinfo[index1].dob)),                                ],
                              ),
                              Row(
                                children: [
                                  Text('Native:City/Country'),
                                  Expanded(child: Text(result[index].familyinfo[index1].phone)),                                ],
                              ),
                              Row(
                                children: [
                                  Text('Name of Samajik Sanstha Involved'),
                                  Expanded(child: Text(result[index].familyinfo[index1].occ.toString())),                                ],
                              ),
                              Row(
                                children: [
                                  Text('Extra1'),
                                  Expanded(child: Text(result[index].familyinfo[index1].email)),                                ],
                              ),
                              Row(
                                children: [
                                  Text('Extra2'),
                                  Expanded(child: Text(result[index].familyinfo[index1].relation)),                                ],
                              ),


                            ],
                          ),)
                 ,
               )
              ],
            ) : Text(""),
          ],
        ),
      ),
    ),

                      )
                  ),
                  if(_isLoadMoreRunning==true)
                    Center(
                      child: CircularProgressIndicator(),
                    ),

                  if(_hashNextPage==false)
                    Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      color: Colors.amber,
                      child: Center(
                        child: Text("All Record Fatched SuccessFully"),
                      ),
                    )
                ],
              ));
  }
}
