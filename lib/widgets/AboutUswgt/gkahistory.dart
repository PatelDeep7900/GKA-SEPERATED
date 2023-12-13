import 'package:flutter/material.dart';

import '../../constants.dart';

class gkahistory extends StatelessWidget {
  const gkahistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          const Align(alignment: Alignment.centerLeft,child: Text('History of GKA:',style: TextStyle(fontSize: 18),)),
          const SizedBox(height: 3,),
          RichText(
              text: const TextSpan(
                  children: [
                    TextSpan(
                        text: historygka,
                        style: TextStyle(fontSize: 12,color: Colors.black)
                    ),
                  ]
              )
          ),
        ],
      ),
    );
  }
}
