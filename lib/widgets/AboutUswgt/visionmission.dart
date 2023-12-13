import 'package:flutter/material.dart';

import '../../constants.dart';

class visionmission extends StatelessWidget {
  const visionmission({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Our Vision",style: TextStyle(color: Colors.orange,fontSize: 18)),
                    Text(vision),
                  ],
                ),
              ),
            ),
          ),
          const Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Our mission",style: TextStyle(color: Colors.orange,fontSize: 18)),
                  Text(mission),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
