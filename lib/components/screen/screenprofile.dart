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
    final url = Uri.parse(uri);
    final response = await http.get(url);
    setState(() {
      Welcome welcome = Welcome.fromJson(json.decode(response.body));
      result = welcome.results!;
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
                          const CircleAvatar(
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Basic Information",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      _isEdit == true
                                          ? IconButton(
                                              onPressed: () {
                                                _saveProfile();
                                              },
                                              icon: const Icon(Icons.save))
                                          : IconButton(
                                              onPressed: () {
                                                _editProfile();
                                              },
                                              icon: const Icon(Icons.edit))
                                    ],
                                  ),
                                ),
                                Card(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                'Name:',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: _isEdit == true
                                                  ? TextField(
                                                      controller: inoutcint,
                                                      decoration:
                                                          const InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                            EdgeInsets.all(5),
                                                      ),
                                                      autofocus: true,
                                                      style: const TextStyle(
                                                          fontSize: 15),
                                                      cursorHeight: 13,
                                                    )
                                                  : Text(
                                                      result[0].name.toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Address1:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                result[0].address.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Address1:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                result[0].address1.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                  'Country/State/City:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                "${result[0].strcities.toString()}-${result[0].strstate.toString()}-${result[0].strcountry.toString()}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Zip/Pin:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(result[0].strpin.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Contact Information",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Card(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                'Home Phone:',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                result[0].phone.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Mobile No:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(result[0].mob.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Email:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(result[0].email.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Business Information",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Card(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                'Website:',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(
                                                result[0].bWebsite.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Type of Business:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].bDetail.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Location:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].bLocation.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Family Details",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Card(
                                    color: Colors.grey,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                'Parents:',
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: Text(result[0].parent.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Spouse Parents:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].sParents.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                  'Native:city/country:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].natCity.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text(
                                                  'Name of Samajik sanstha involved:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].sSanstha.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Extra1:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].ext1.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('Extra2:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(result[0].ext2.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 45,
                                            child: ListTile(
                                              title: const Text('About Family:',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              subtitle: Text(
                                                  result[0].aboutFamily.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Family Information",
                                    style: TextStyle(
                                        color: Colors.red,
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
                                        color: Colors.grey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, top: 0),
                                              child: CircleAvatar(
                                                  radius: 10,
                                                  child: Text("#$index",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10))),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("Name:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .name.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("Relation:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .relation.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("Data of Birth:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .dob.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("occupation:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .occ
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("Phone:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .phone.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 45,
                                              child: ListTile(
                                                title: const Text("Email:",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    result[0]
                                                        .familyinfo![index]
                                                        .email.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                          ],
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

  _editProfile() {
    setState(() {
      _isEdit = true;
    });
  }

  _saveProfile() {
    setState(() {
      _isEdit = false;
    });
  }
}
