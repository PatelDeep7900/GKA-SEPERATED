import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../fullimagetest.dart';
import '../../models/Gallerymdl/convoimgmodel.dart';

class convotab extends StatefulWidget {
   convotab({super.key,required this.title,required this.piclist});

  String title;
  List<convoimgclass> piclist;

  @override
  State<convotab> createState() => _convotabState();
}

class _convotabState extends State<convotab> {
  bool _loading=true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if(mounted){
        setState(() {
          _loading=false;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Skeletonizer(
        enabled: _loading,
        ignoreContainers: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
               Center(child: Text(widget.title,style: const TextStyle(fontSize: 18,color: Color(0xFFF5951B),fontWeight: FontWeight.bold)),),
              const SizedBox(height: 5,),
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0xFFF1F1F1),
                child: GridView.builder(
                  itemCount: widget.piclist.length,
                  padding: const EdgeInsets.all(5),
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageFullScreen(widget.piclist, index),
                          ),
                        );
                      },
                      child: SizedBox(
                        height: 100,
                        width: 150,
                        child: Image.asset(widget.piclist[index].link,fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
