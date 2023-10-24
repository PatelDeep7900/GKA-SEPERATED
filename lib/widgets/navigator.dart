import 'package:flutter/material.dart';

void NavigationPushreplace(BuildContext context,Widget screen) {
  final navigatior = Navigator.of(context);
  navigatior.pushReplacement(MaterialPageRoute(builder: (context) => screen,));
}

void NavigationPush(BuildContext context,Widget screen) {
  final navigatior = Navigator.of(context);
  navigatior.push(MaterialPageRoute(builder: (context) => screen,));
}

void NavigationPop(BuildContext context) {
  final navigatior = Navigator.of(context);
  navigatior.pop();
}