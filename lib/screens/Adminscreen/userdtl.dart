
import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gka/popupbutton.dart';
import 'package:http/http.dart' as http;


class userdtl extends StatefulWidget {
   userdtl({super.key,required this.index,required this.result});


  int index;
  dynamic result;

  @override
  State<userdtl> createState() => _userdtlState();
}

class _userdtlState extends State<userdtl> {

  bool _apprejbtn=true;

  Future<void> _approve(String id,BuildContext context,dynamic result ) async{


     try {
       String url = 'http://e-gam.com/GKARESTAPI/c_approval';
       print(url);
       final response = await http.post(
           Uri.parse(url),

           body: {
           "cond": "approve",
           "id":id.toString()

           }
       );
       if (response.statusCode == 200) {
         var data = jsonDecode(response.body);
         bool res = data['result'];
         if (res== true) {

          setState(() {


            result[widget.index].userApprov="1";
            result[widget.index].imgapprove="A";


            _apprejbtn=false;
          });
           if(!mounted)return;
           sucesspopup(context, "This Profile Successfully Approved");

         } else {
           if(!mounted)return;
           errorpopup(context, "Something Wrong");
         }
       }
     }on Exception catch (e) {
        errorpopup(context, e.toString());
       rethrow;
     }
   }
  Future<void> _reject(String id,BuildContext context,dynamic result ) async{


    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_approval';
      print(url);
      final response = await http.post(
          Uri.parse(url),

          body: {
            "cond": "reject",
            "id":id.toString()

          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        bool res = data['result'];
        if (res== true) {

          setState(() {
            result[widget.index].userApprov="0";
            result[widget.index].imgapprove="N";
            _apprejbtn=true;
          });
          if(!mounted)return;
          sucesspopup(context, "This Profile Reject");

        } else {
          if(!mounted)return;
          errorpopup(context, "Something Wrong");
        }
      }
    }on Exception catch (e) {
      errorpopup(context, e.toString());
      rethrow;
    }
  }

  void _approvereject(){

     if(widget.result[widget.index].userApprov=="1"
         &&
         widget.result[widget.index].imgapprove=="A"){

       setState(() {
       });

     }else{
       setState(() {
       });
     }
   }
  void buttonhide(){

    if(widget.result[widget.index].userApprov=="1"
        &&
        widget.result[widget.index].imgapprove=="A"){

      setState(() {
        _apprejbtn=false;
      });
    }
  }

   @override
  void initState() {
     buttonhide();
     _approvereject();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Visibility(
        visible: _apprejbtn,
        child: Row(
          children: [
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),onPressed: (){
                _approve(widget.result[widget.index].id,context,widget.result);
              }, child: const Text('Approve')),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),onPressed: (){
                _reject(widget.result[widget.index].id,context,widget.result);
              }, child: const Text('Reject')),
            ))
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('User Full Details'),
        centerTitle: true,
        backgroundColor: const Color(0xd9fd6d0c),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  autoPlay: false,
                  enableInfiniteScroll: false
              ),
              items: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          widget.result[widget.index].img1=="" ? Image.asset("assets/images/nopic.png")   : Image.network(widget.result[widget.index].img1, fit: BoxFit.cover, width: 1000.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: const Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          widget.result[widget.index].img2=="" ? Image.asset("assets/images/nopic.png") :    Image.network(widget.result[widget.index].img2, fit: BoxFit.cover, width: 1000.0),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: const Text(
                                'Extra ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                )],
            ),

            widget.result[widget.index].userApprov==  "0" ?
                 const Text("Profile Approval Pending",style:TextStyle(color: Colors.red),)
                :const  Text("Profile Approval Approved",style:TextStyle(color: Colors.green),),
            const Divider(),

            widget.result[widget.index].imgapprove==  "A" ?
            const Text("Image Approved",style:TextStyle(color: Colors.green),)
            : const  Text("Image Approval Pending",style:TextStyle(color: Colors.red),),

            const Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.7,
              child: DefaultTabController(
                length: 5,
                child: Column(
                  children: <Widget>[
                    ButtonsTabBar(
                      backgroundColor: Colors.blue[600],
                      unselectedBackgroundColor: Colors.white,
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: TextStyle(
                        color: Colors.blue[600],
                        fontWeight: FontWeight.bold,
                      ),
                      borderWidth: 1,
                      unselectedBorderColor: Colors.blue,
                      radius: 100,
                      tabs:  const [
                        Tab(
                          text: "Basic Info",
                        ),
                        Tab(
                          text: "Contact Info",
                        ),
                        Tab(
                          text: "Business Info",
                        ),
                        Tab(
                          text: "Family Details",
                        ),
                        Tab(
                          text: "Family info",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          _basicinfo(context,widget.index,widget.result),
                          _continfo(context,widget.index,widget.result),
                          _bussinfo(context,widget.index,widget.result),
                          _familydtl(context,widget.index,widget.result),
                          _familyinfo(context,widget.index,widget.result)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _basicinfo(BuildContext context,int index,result){
    return  ListView(
      physics: const NeverScrollableScrollPhysics(),
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
            physics: const NeverScrollableScrollPhysics(),
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
                    const DataCell( SizedBox(width:65,child: Text('Name',style: TextStyle(fontSize: 13),)),),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].name.toString(),style: const TextStyle(fontSize: 13),)),
                  ]),
                  DataRow(cells: [
                    const DataCell( SizedBox(width:65,child: Text('Address1',style: TextStyle(fontSize: 13),)),),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].address.toString(),style: const TextStyle(fontSize: 13),)),
                  ]),

                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Address2',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].address1.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Country',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].strcountry.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('State',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].strstate.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('City',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].strcities.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Zip/Pin',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(SizedBox(width: MediaQuery.of(context).size.width*0.6,child: Text(result[index].strpin.toString(),style: TextStyle(fontSize: 13)))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _continfo(BuildContext context,int index,result){
    return  ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
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
                    const DataCell( SizedBox(width:65,child: Text('Country Code',style: TextStyle(fontSize: 13),)),),
                    const DataCell(Text(":")),
                    DataCell(Container(width:MediaQuery.of(context).size.width*0.6,child: Text('+1',style: TextStyle(fontSize: 13),))),
                  ]),

                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Home Phone',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].phone.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Mobile',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].mob.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Email',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].email.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bussinfo(BuildContext context,int index,result){
    return  ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
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
                    const DataCell( SizedBox(width:65,child: Text('Website',style: TextStyle(fontSize: 13),)),),
                    const DataCell(Text(":")),
                    DataCell(SizedBox(width:MediaQuery.of(context).size.width*0.6,child: Text(result[index].bWebsite.toString(),style: TextStyle(fontSize: 13),))),
                  ]),

                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Business Type',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].bDetail.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Business Location',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].bLocation.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _familydtl(BuildContext context,int index,result){
    return  ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
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
                    const DataCell( SizedBox(width:65,child: Text('Parents',style: TextStyle(fontSize: 13),)),),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].parent.toString().toString(),style: const TextStyle(fontSize: 13),)),
                  ]),

                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Spouse Parents',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].sParents.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Native:city/country',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(SizedBox(width:MediaQuery.of(context).size.width*0.6,child: Text(result[index].natCity.toString(),style: TextStyle(fontSize: 13)))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Samajik sanstha',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].sSanstha.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Extra1',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].ext1.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('Extra2',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].ext2.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                  DataRow(cells: [
                    const DataCell(SizedBox(width:65,child: Text('About Family',style: TextStyle(fontSize: 13)))),
                    const DataCell(Text(":")),
                    DataCell(Text(result[index].aboutFamily.toString(),style: const TextStyle(fontSize: 13))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _familyinfo(BuildContext context,int index,result){
    return  ListView(
      children: [
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
            itemCount: result[index].familyinfo!.length,
            itemBuilder: (context, index1) {
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
                            const DataCell( SizedBox(width:72,child: Text('name',style: TextStyle(fontSize: 13),)),),
                            const DataCell(Text(":")),
                            DataCell(Text(result[index].familyinfo![index1].name.toString(),style: TextStyle(fontSize: 13),)),
                          ]),
                          DataRow(cells: [
                            const DataCell( SizedBox(width:72,child: Text('Relation',style: TextStyle(fontSize: 13),)),),
                            const DataCell(Text(":")),
                            DataCell(Text(result[index].familyinfo![index1].relation.toString(),style: TextStyle(fontSize: 13),)),
                          ]),

                          DataRow(cells: [
                            const DataCell(SizedBox(width:72,child: Text('Date Of Birth',style: TextStyle(fontSize: 13)))),
                            const DataCell(Text(":")),
                            DataCell(SizedBox(width:MediaQuery.of(context).size.width*0.6,child: Text(result[index].familyinfo![index1].dob.toString(),style: TextStyle(fontSize: 13)))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(width:72,child: Text('occupation',style: TextStyle(fontSize: 13)))),
                            const DataCell(Text(":")),
                            DataCell(Text(result[index].familyinfo![index1].occ.toString(),style: TextStyle(fontSize: 13))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(width:72,child: Text('Phone',style: TextStyle(fontSize: 13)))),
                            const DataCell(Text(":")),
                            DataCell(Text(result[index].familyinfo![index1].phone.toString(),style: TextStyle(fontSize: 13))),
                          ]),
                          DataRow(cells: [
                            const DataCell(SizedBox(width:72,child: Text('Email',style: TextStyle(fontSize: 13)))),
                            const DataCell(Text(":")),
                            DataCell(Text(result[index].familyinfo![index1].email.toString(),style: TextStyle(fontSize: 13))),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
