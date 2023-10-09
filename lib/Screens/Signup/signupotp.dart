import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gka/Screens/Signup/verification_screen.dart';

class Example {
  final String title;
  final String subtitle;
  final GestureTapCallback? onTap;
  final Route<Object?> route;

  Example({
    required this.title,
    required this.subtitle,
    required this.route,
    this.onTap,
  });
}


class otpverification extends StatefulWidget {
  const otpverification({super.key});
  @override
  State<otpverification> createState() => _otpverificationState();
}
class _otpverificationState extends State<otpverification> {

  Color accentPurpleColor = Color(0xFF6A53A1);
  Color primaryColor = Color(0xFF121212);
  Color accentPinkColor = Color(0xFFF99BBD);
  Color accentDarkGreenColor = Color(0xFF115C49);
  Color accentYellowColor = Color(0xFFFFB612);
  Color accentOrangeColor = Color(0xFFEA7A3B);

  List<Example> examples = [
    Example(
      title: "OTP TextField Example 2",
      subtitle: "Verification Screen 2",
      route: MaterialPageRoute(
        builder: (context) => VerificationScreen2(),
      ),
    ),
  ];


  TextStyle? createStyle(Color color) {
    ThemeData theme = Theme.of(context);
    return theme.textTheme.displaySmall?.copyWith(color: color);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xd9fd6d0c),
        title: const Text("GKA"),
        centerTitle: true,
      ),

      body: Builder(
        builder: (context) {
          return ListTile(
            title: Text(
              examples[0].title,
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VerificationScreen2(),
                ),
              );
            },
          );
        },
      ),
    );
  }
  void nav(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen2(),
      ),
    );
  }
}
