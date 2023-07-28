import 'package:flutter/material.dart';
import 'package:gka/components/navbar/menu.dart';
class profilepage extends StatelessWidget {
  const profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: menubar(),
      appBar: AppBar(
        title: Text("GKA"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("This is profile page"),
      ),
    );
  }
}
