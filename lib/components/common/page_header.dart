import 'package:flutter/material.dart';
import 'package:gka/components/contact_page.dart';
import 'package:icons_plus/icons_plus.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
                alignment: Alignment.topLeft,
                width:172,
                height:size.height * 0.3,
                child: Image.asset('assets/images/friendship.png'),
              ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Gujarati',style: TextStyle(color: Colors.white,fontSize: 20),),
                  SizedBox(height: 4,),
                  Text('Kshatriya',style: TextStyle(color: Colors.white,fontSize: 20)),
                  SizedBox(height: 4,),
                  Text('Association',style: TextStyle(color: Colors.white,fontSize: 20)),
                  SizedBox(height: 4,),
                  Text('USA & Canada',style: TextStyle(color: Colors.white,fontSize: 20)),
                ],
              ),
            ),
          ),
          SizedBox(width: 8,),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              child:  Column(
                children: [
                  Logo(Logos.facebook_logo),
                  SizedBox(height: 10,),
                  Logo(Logos.gmail),
                  SizedBox(height: 10,),
                  InkWell(child: Icon(FontAwesome.phone,color: Colors.blue,),onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ContactPage()));
                  },)

                ],
              ),

            ),
          )

        ],
      ),
    );
  }
}
