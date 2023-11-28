import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gka/models/homeModels/welcomejson.dart';
import 'package:gka/popupbutton.dart';
import 'package:gka/userdtl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class gview extends StatefulWidget {
const gview({Key? key}) : super(key: key);

  @override
  State<gview> createState() => _gviewState();
}

class _gviewState extends State<gview> {

  ScrollController scrollController = ScrollController();
  List<Results> result = [];
  int _page = 0;
  final int _limit = 10;
  bool _isFirstLoadRunning = false;
  bool _hashNextPage = true;
  bool _isLoadMoreRunning = false;


  void _firstLoad() async {

    setState(() {
      _isFirstLoadRunning = true;
    });
    try {

      var url ="http://e-gam.com/GKARESTAPI/c_pendinglist?off=$_page&lim=$_limit";
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
        var url ="http://e-gam.com/GKARESTAPI/c_pendinglist?off=$_page&lim=$_limit";
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
      body: _isFirstLoadRunning
          ? const Center(
            child: CircularProgressIndicator(),
          )
          :   Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("User Approve,Reject & Pending List",style: TextStyle(fontSize: 18),),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
                itemCount: result.length,
                padding: const EdgeInsets.all(5),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => userdtl( index: index, result: result),));
                    },
                    child: Card(
                      color: (index % 2 == 0) ? Colors.white70 : Colors.white,
                      child: ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: ClipOval(
                                child: Image.asset('assets/images/logo.png')),
                          ),
                          trailing:  result[index].userApprov=="1"&&result[index].imgapprove=="A"?
                          const Text(
                            "Approved",
                            style: TextStyle(color: Colors.green, fontSize: 15),
                          ):const Text(
                            "Pending",
                            style: TextStyle(color: Colors.red, fontSize: 15),
                          ),
                          title: Text(result[index].name.toString())),
                    ),
                  );
                }),
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
    );
  }
}