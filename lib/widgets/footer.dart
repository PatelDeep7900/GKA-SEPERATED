import 'dart:convert';

import 'package:flutter/material.dart';

class footer extends StatelessWidget {
   footer({super.key});

  final List<String> _CMlist=[
    "Ravindra R. Parmar",
    "Arun Arya",
    "Jayantibhai R. Chauhan",
    "Paresh Pankhavala",
    "Kanti R. Chavada",
    "Thakorbhai Bulsara",
    "Vinod Chauhan",
    "Jekishanbhai R. Chauhan",
    "Harish Doolabh",
    "Avani Chauhan",
    "Parbhubhai Govindji",
    "Daxaben B. Chauhan",
    "Mahendrabhai Solanki",
  ];
   final List<String> _BOAlist=[
     "Amritbhai Champaneri",
     "Jaydevbhai Varma",
     "Kamlesh Chauhan",
     "Jasvantbhai Nana",
     "Jagubhai Champaneri",
     "Rajesh Kumar Chauhan",
     "Natvarbhai Nana",
     "Shashi Champaneri",
     "Maheshbhai Solanki",
     "Jayantibhai Panchal",
   ];


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFF222223),
        height: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width/2-0.5,
            child: Column(
             children: [
               const Padding(
                 padding: EdgeInsets.only(top: 5),
                 child: Text('COMMITTEE MEMBERS',style: TextStyle(color: Colors.white),),
               ),
               SizedBox(width: MediaQuery.of(context).size.width/2-0.5,child: Divider(color: Colors.white,),),
               Column(
                 children: _CMlist.map((e) => Text(e,style: const TextStyle(color: Colors.white,decoration: TextDecoration.underline),)).toList(),
               )
             ],
            ),
          ),
          const VerticalDivider(color: Colors.white,width: 1,),
          SizedBox(
            width: MediaQuery.of(context).size.width/2-0.5,
            child:  Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('BOARD OF ADVISORS',style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: MediaQuery.of(context).size.width/2-0.5,child: const Divider(color: Colors.white,),),
                Column(
                  children: _BOAlist.map((e) => Text(e,style: const TextStyle(color: Colors.white,decoration: TextDecoration.underline),)).toList(),
                )
              ],
            ),
          ),
        ],
      ),
      );
  }
}
