import 'package:flutter/material.dart';

import '../../constants.dart';
class contactscreen extends StatefulWidget {
  const contactscreen({super.key});

  @override
  State<contactscreen> createState() => _contactscreenState();
}

class _contactscreenState extends State<contactscreen> {
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:SingleChildScrollView(
        child: Card(
          child:Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),

                Center(child: Text("Contact Information",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                Divider(),
                const SizedBox(height: defaultPadding),


                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    hintText: "Country Code",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),

                ),

                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Home Phone",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),


                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Mobile Number",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),


                Padding(

                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      hintText: "Email Address",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),

                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "submit_btn",
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text(
                      "SUBMIT",
                    ),
                  ),
                ),

                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "reset_btn",
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text(
                      "RESET",
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),

    );
  }
}

