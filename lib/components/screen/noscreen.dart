import 'package:flutter/material.dart';
class aboutusscree extends StatelessWidget {
  const aboutusscree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("You Are Under Approval Mode!",style: TextStyle(color: Colors.red,fontSize: 15,fontWeight: FontWeight.bold),),
              Divider(),
              SizedBox(height: 10,),
              Text('Welcome to GKA USA & CANADA',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 5,),
              Text.rich(
                TextSpan(
                  text: 'Gujarati Kshatriya Associationwas founded in 1989. The goal of our Non-Profit organization is to unite and serve all our Gujarati Kshatriya communities living in USA-CANADA and to promote and preserve our heritage and language, and bring cultural awareness to future generations by providing a platform to all our community families while serving the community needs.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 12,),
              Text.rich(
                TextSpan(
                  text: 'The charitable and social activities developed steadily through the past 30+ years and the group cohesiveness of our past and present executive committee members and Board of Trustees along with many volunteers have culminated in a strong and vibrant Gujarati Kshatriya Association. As we continue our progress in 21st century, the foundation of social adaptiveness set forth by our previous executive committee members, has strengthen our resolve and made us proud of our cultural heritage.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SizedBox(height: 12,),
              Text.rich(
                TextSpan(
                  text: 'We have very active Mandals like GKA South East Atlanta, Vancouver Mochi Gnati Mandal, GKSNA NY/NJ and Mochi Gnati Mandal of Ontario-Canada where they regularly celebrate Diwali-Mela and picnic during the year. With the help of every Gujarati Kshatriya Association member in our community, we encourage each and every family to participate in cultural and social activities to build our strong youth generation.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
