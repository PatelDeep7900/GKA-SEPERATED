import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/Contactmdl/contactmodel.dart';

class contacttab extends StatelessWidget {
  const contacttab({super.key});

  @override
  Widget build(BuildContext context) {

    void copytxt(String txt){
      Clipboard.setData(ClipboardData(text: txt));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Text copied to clipboard"),
        ),
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const Center(child: Text('ADMIN CONTACT',style: TextStyle(color: Color(0xFFF5951B),fontSize: 22),)),
            Expanded(
              child: ListView.builder(
                itemCount: contactlist.length,
                // shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                 return Padding(
                   padding: const EdgeInsets.only(bottom: 5),
                   child: Card(
                     color:  const Color(0xFFF1F1F1),
                     elevation: 5,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(contactlist[index].position,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 3,),
                           Row(
                             children: [
                               const Icon(Icons.person),
                               const SizedBox(width: 3,),
                               Text(contactlist[index].name,style: const TextStyle(color: Color(0xFF8a2be2),fontWeight: FontWeight.bold),),
                             ],
                           ),
                           const SizedBox(height: 3,),
                           contactlist[index].add!=''? Row(
                             children: [
                               const Icon(Icons.maps_home_work_rounded),
                               const SizedBox(width: 3,),
                               Text(contactlist[index].add,style: const TextStyle(fontWeight: FontWeight.bold)),
                             ],
                           ):Container(),
                           const SizedBox(height: 3,),
                           Row(
                             children: [
                               const Icon(Icons.email_rounded),
                               const SizedBox(width: 3,),
                               Text(contactlist[index].email,style: const TextStyle(color: Color(0xFF8a2be2),fontWeight: FontWeight.bold),),
                                IconButton(onPressed: () {
                                  copytxt(contactlist[index].email);
                                }, icon: const Icon(Icons.copy_outlined),),
                             ],
                           ),
                           const SizedBox(height: 3,),
                           Row(
                             children: [
                               const Icon(Icons.phone_android),
                               const SizedBox(width: 3,),
                               Text(contactlist[index].phone1,style: const TextStyle(color: Color(0xFF8a2be2),fontWeight: FontWeight.bold)),
                               IconButton(onPressed: () {
                                 copytxt(contactlist[index].phone1);
                               }, icon: const Icon(Icons.copy_outlined),),
                             ],
                           ),
                           const SizedBox(height: 3,),
                           contactlist[index].phone2!=''?Row(
                             children: [
                               const Icon(Icons.phone_android),
                               const SizedBox(width: 3,),
                               Text(contactlist[index].phone2,style: const TextStyle(color: Color(0xFF8a2be2),fontWeight: FontWeight.bold),),
                               IconButton(onPressed: () {
                                 copytxt(contactlist[index].phone2);
                               }, icon: const Icon(Icons.copy_outlined),),
                             ],
                           ):Container()
                         ],
                       ),
                     ),
                   ),
                 );
              },),
            ),
          ],
        ),
      ),
    );
  }
}


