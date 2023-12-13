import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/Homemdl/carouselslider.dart';
import '../widgets/Homewgt/admincontact.dart';
import '../widgets/Homewgt/comiteemember.dart';
import '../widgets/footer.dart';


class hometab extends StatefulWidget {
  const hometab({super.key});

  @override
  State<hometab> createState() => _hometabState();
}

class _hometabState extends State<hometab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items:sliderlist1.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container
                    (
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Image.asset(i),
                  );
                },
              );
            }).toList(),
          ),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(child: Text('Welcome to GKA USA & CANADA',style: TextStyle(color: Color(0xFFF5951B),fontSize: 18),)),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: RichText(
                text: const TextSpan(
                    children: [
                      TextSpan(
                          text: aboutgka,
                          style: TextStyle(fontSize: 12,color: Colors.black)
                      ),
                    ]
                )
            ),
          ),
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(child: Text('Team Committee Members',style: TextStyle(color: Color(0xFFF5951B),fontSize: 18),)),
          ),
          const SizedBox(height: 10,),
          const comiteemember(),
          const SizedBox(height: 10,),
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: Center(child: Text('ADMIN CONTACT',style: TextStyle(color: Color(0xFFF5951B),fontSize: 18),)),
          ),
          const SizedBox(height: 10,),
          const admincontact(),
          const SizedBox(height: 10,),
          footer(),
        ],
      ),
    );
  }
}
