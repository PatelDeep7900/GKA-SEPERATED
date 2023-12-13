import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImg extends StatelessWidget {
  const FullImg({
    required this.imageProvider,
  });

  final ImageProvider imageProvider;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xd9fd6d0c),),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoView(
          backgroundDecoration: const BoxDecoration(color:  Colors.white),
          imageProvider: imageProvider,
          heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
        ),
      ),
    );
  }
}