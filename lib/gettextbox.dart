import 'package:flutter/material.dart';


class gettextvalueonclick extends StatelessWidget {
   gettextvalueonclick({super.key});

  final TextEditingController inpcont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:Column(
        children: [
          Container(
            child:
            TextField(
              controller: inpcont,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
            ),
          ),

          TextButton(onPressed: () {
            print(inpcont.text);
          }, child: Text("Press me"))
        ],
      ),


    );
  }
}
