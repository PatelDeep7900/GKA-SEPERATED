import 'package:flutter/material.dart';

import '../../models/AboutUsmdl/conventionhistorymodel.dart';


class conventionhistory extends StatelessWidget {
  const conventionhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft,child: Text('History of GKA:',style: TextStyle(fontSize: 18),)),
          const SizedBox(height: 3,),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: conventionlist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: const BorderRadius.all(Radius.circular(13)),
                    border: Border.all(color: Colors.grey,strokeAlign: 0.8,width: 0.8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Image.asset(conventionlist[index].src,height: 200,width: 200,),
                        RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(text: '${conventionlist[index].title}\n',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black)),
                                  TextSpan(text: '${conventionlist[index].description}\n\n',style: const TextStyle(fontSize: 12,color: Colors.black)),
                                  const TextSpan(text: 'Activities:',style: TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
                                  TextSpan(text: conventionlist[index].Activities,style: const TextStyle(fontSize: 12,color: Colors.black)),
                                ]
                            )),
                      ],
                    ),
                  ),
                ),
              );
            },)
        ],
      ),
    );
  }
}
