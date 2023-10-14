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


  int _page = 0;
  int _len=0;
  String _searchval = "";

  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  List<Results> result = [];

  List<Results> searchresult = [];




  bool _hashNextPage=true;
  bool _isLoadMoreRunning=false;




void _search(String searchval) async {
  setState(() {
    _isFirstLoadRunning = true;
  });

  try {
    var url =
        "http://e-gam.com/GKARESTAPI/serchbyname?nm=$searchval";
    var uri = Uri.parse(url);
    final response = await http.get(uri);
    setState((){
    Welcome welcome = Welcome.fromJson(json.decode(response.body));
    searchresult =welcome.results!;
    });

    setState(() {
      _isFirstLoadRunning = false;
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


        final response = await http.get(uri);

        var a=jsonDecode(response.body);
        if(a['datafound']==true){
          Welcome welcome = Welcome.fromJson(json.decode(response.body));
          if(result.isNotEmpty) {
            setState(() {
              result = result + welcome.results!;
            });
          }
        }else{
         setState(() {
           _hashNextPage=false;
         });
        }
      } catch (err) {

        print(err.toString());
      }



      setState(() {
        _isLoadMoreRunning = false;
      });

    }else{
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
        body:Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      searchresult = [];
                    });
                    if(value.length>2) {
                      setState(() {
                        _len = value.length;
                        _search(value);
                      });
                    }
                    setState(() {
                      _len=value.length;
                      if(_len==0){
                        _hashNextPage=true;
                      }
                    });

                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
              _isFirstLoadRunning
                  ?  const Expanded(
                    child: Center(
                child: CircularProgressIndicator(),
              ),
                  )
                  : Expanded(
                    child: Column(
                children: [

                    Expanded(
                        child: _len==0?ListView.builder(

                          controller: scrollController,
                          itemCount:result.length,
                          itemBuilder:(context, index) =>
                              Card(
                                color: (index % 2 == 0) ? Colors.white : Colors.white60,

                                key: ValueKey(result[index].id),
                                shape: Border.all(color: Colors.grey),
                                elevation: 8,
                                child: InkWell(
                                  onTap: () {

                                    // result[index].id
                                  },
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          "assets/images/nopic.png"),
                                    ),
                                    title: Text(
                                      '${index + 1}',
                                    ),
                                    subtitle: Text(result[index].name.toString()),
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
                                                    Text(result[index].address.toString()),
                                                    Text(result[index].address1.toString()),
                                                    Text(result[index].strcountry.toString()),
                                                    Text(result[index].strstate.toString()),
                                                    Text(result[index].strcities.toString()),
                                                    Text(result[index].strpin.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text("Contact Information"),
                                        children: [
                                          Card(
                                            child: Row(
                                              children: [
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Country Code'),
                                                    Text('Home Phone'),
                                                    Text('Mobile'),
                                                    Text('Email'),
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
                                                  ],
                                                ),
                                                const SizedBox(width: 15,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('+1'),
                                                    Text(result[0].phone.toString()),
                                                    Text(result[0].mob.toString()),
                                                    Text(result[0].email.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text("Businees Details"),
                                        children: [
                                          Card(
                                            child: Row(
                                              children: [
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Website'),
                                                    Text('Business Type'),
                                                    Text('Location'),
                                                  ],
                                                ),
                                                const SizedBox(width: 5,),
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(':'),
                                                    Text(':'),
                                                    Text(':'),
                                                  ],
                                                ),
                                                const SizedBox(width: 15,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(result[0].bWebsite.toString()),
                                                    Text(result[0].bDetail.toString()),
                                                    Text(result[0].bLocation.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),)
                                        ],
                                      ),

                                      result[index].userApprov=="1" ?
                                      ExpansionTile(
                                        title: const Text("Family"),
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: result[index].familyinfo!.length,
                                            itemBuilder: (context, index1) =>
                                                Expanded(
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        const Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('name'),
                                                            Text('Relation'),
                                                            Text('Date of Birth'),
                                                            Text('Occupation'),
                                                            Text('Phone'),
                                                            Text('Email'),
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
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(result[index].familyinfo![index1].name.toString()),
                                                              Text(result[index].familyinfo![index1].relation.toString()),
                                                              Text(result[index].familyinfo![index1].dob.toString()),
                                                              Text(result[index].familyinfo![index1].occ.toString()),
                                                              Text(result[index].familyinfo![index1].phone.toString()),
                                                              Text(result[index].familyinfo![index1].email.toString()),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ,
                                          )
                                        ],
                                      ) : const Text(""),
                                    ],
                                  ),
                                ),
                              ),

                        ): ListView.builder(

                          // controller: scrollController,
                          itemCount:searchresult.length,
                          itemBuilder:(context, index) =>
                              Card(
                                key: ValueKey(searchresult[index].id),
                                shape: Border.all(color: Colors.grey),
                                elevation: 8,
                                child: InkWell(
                                  onTap: () {

                                    // result[index].id
                                  },
                                  child: ExpansionTile(
                                    leading: const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          "assets/images/nopic.png"),
                                    ),
                                    title: Text(
                                      '${index + 1}',
                                    ),
                                    subtitle: Text(searchresult[index].name.toString()),
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
                                                    Text(searchresult[index].address.toString()),
                                                    Text(searchresult[index].address1.toString()),
                                                    Text(searchresult[index].strcountry.toString()),
                                                    Text(searchresult[index].strstate.toString()),
                                                    Text(searchresult[index].strcities.toString()),
                                                    Text(searchresult[index].toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text("Contact Information"),
                                        children: [
                                          Card(
                                            child: Row(
                                              children: [
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Country Code'),
                                                    Text('Home Phone'),
                                                    Text('Mobile'),
                                                    Text('Email'),
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
                                                  ],
                                                ),
                                                const SizedBox(width: 15,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text('+1'),
                                                    Text(searchresult[0].phone.toString()),
                                                    Text(searchresult[0].mob.toString()),
                                                    Text(searchresult[0].email.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      ExpansionTile(
                                        title: const Text("Businees Details"),
                                        children: [
                                          Card(
                                            child: Row(
                                              children: [
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Website'),
                                                    Text('Business Type'),
                                                    Text('Location'),
                                                  ],
                                                ),
                                                const SizedBox(width: 5,),
                                                const Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(':'),
                                                    Text(':'),
                                                    Text(':'),
                                                  ],
                                                ),
                                                const SizedBox(width: 15,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(searchresult[0].bWebsite.toString()),
                                                    Text(searchresult[0].bDetail.toString()),
                                                    Text(searchresult[0].bLocation.toString()),
                                                  ],
                                                ),
                                              ],
                                            ),)
                                        ],
                                      ),

                                      searchresult[index].userApprov=="1" ?
                                      ExpansionTile(
                                        title: const Text("Family"),
                                        children: [
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: searchresult[index].familyinfo!.length,
                                            itemBuilder: (context, index1) =>
                                                Expanded(
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        const Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('name'),
                                                            Text('Relation'),
                                                            Text('Date of Birth'),
                                                            Text('Occupation'),
                                                            Text('Phone'),
                                                            Text('Email'),
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
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(searchresult[index].familyinfo![index1].toString()),
                                                              Text(searchresult[index].familyinfo![index1].relation.toString()),
                                                              Text(searchresult[index].familyinfo![index1].dob.toString()),
                                                              Text(searchresult[index].familyinfo![index1].occ.toString()),
                                                              Text(searchresult[index].familyinfo![index1].toString()),
                                                              Text(searchresult[index].familyinfo![index1].toString()),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                            ,
                                          )
                                        ],
                                      ) : const Text(""),
                                    ],
                                  ),
                                ),
                              ),

                        )
                    ),
                    if(_isLoadMoreRunning==true)
                      const Center(
                        child: CircularProgressIndicator(),
                      ),

                    if(_hashNextPage==false)
                      Container(
                        padding: const EdgeInsets.only(top: 10,bottom: 10),
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
}

