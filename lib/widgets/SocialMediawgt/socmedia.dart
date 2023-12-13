import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class socmedia extends StatelessWidget {
   socmedia({super.key,required this.heading,required this.list});

  String heading;
  List list;

  @override
  Widget build(BuildContext context) {
    void openlink(link) async{
      final Uri url = Uri.parse(link);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: const Color(0xFFF1F1F1),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               Center(child: Text(heading.toString(),style: TextStyle(color: Color(0xFFF5951B),fontSize: 22),)),
              const Divider(),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('sr',style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Spacer(flex: 1,),
                  Text('Title',style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(flex: 1,)
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border:Border.all()
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${index+1}'),
                        ),
                        const Spacer(flex: 1,),
                         Text(list[index].title,style: const TextStyle(fontSize: 12),),
                        const Spacer(flex: 1,),
                        IconButton(
                            onPressed: (){
                              openlink(list[index].link);
                            },
                            icon: Container(
                                decoration: const BoxDecoration(
                                     color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              child: const Icon(Icons.download),    
                            )
                        ),
                      ],
                    ),
                  );
                },),
              )
            ],
          ),
        ),
      ),
    );
  }
}
