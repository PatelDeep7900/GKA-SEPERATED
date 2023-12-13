import 'package:flutter/material.dart';

class wwMandals extends StatelessWidget {
  const wwMandals({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView(
        children: [
          Image.asset('assets/ww/1_page-0001.jpg'),
          Image.asset('assets/ww/1_page-0002.jpg'),
          Image.asset('assets/ww/1_page-0003.jpg'),
          Image.asset('assets/ww/1_page-0004.jpg'),
          Image.asset('assets/ww/1_page-0005.jpg'),
          Image.asset('assets/ww/1_page-0006.jpg'),
        ],
      ),
    );
  }
}
