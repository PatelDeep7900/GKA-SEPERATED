import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool agree = false;


  @override
  Widget build(BuildContext context) {

void _doSomething(){

}
    return Form(
      child: Column(
        children: [

          TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your Full Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 1),

          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),

          const SizedBox(height: defaultPadding / 1),

          Row(
            children: [
              Material(
                child: Checkbox(
                  value: agree,
                  onChanged: (value) {
                 setState(() {
                   agree=value!;
                 });
                  },
                ),
              ),
                Row(
                 children: [
                   Text(
                    'I have read and accept',
                    overflow: TextOverflow.ellipsis,
                    ),
                   TextButton(onPressed: () {
                     _showdialog();

                   }, child: Text("terms and conditions"))
                 ],
               )
            ],
          ),
          const SizedBox(height: defaultPadding),


          ElevatedButton(

            onPressed: agree ? _doSomething : null,
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),

        ],
      ),
    );




  }

  void _showdialog(){
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          color: Colors.orangeAccent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("[GKA APP]", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'You are encouraged to periodically review this Privacy Policy to stay informed of updates. You will be deemed to have been made aware of, will be subject to, and will be deemed to have accepted the changes in any revised Privacy Policy by your continued use of the Application after the date such revised. Privacy Policy is posted. This Privacy Policy does not apply to the third-party online/mobile store from which you install the Application or make payments, including any in-game virtual items, which may also collect and use data about you. We are not responsible for any of the data collected by any such third party. This privacy policy was created using Termly.',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

}