import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/Homemdl/comiteemembermodel.dart';



class comiteemember extends StatelessWidget {
  const comiteemember({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black38,
        child: Column(
          children:  [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                enlargeCenterPage: true,
              ),
              items:memberlist.map((index) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 1.0),
                      child: Image.asset(index.src),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );

  }
}
