import 'package:flutter/material.dart';

import '../../constants.dart';

class basicinfoscreen extends StatefulWidget {
  const basicinfoscreen({super.key});

  @override
  State<basicinfoscreen> createState() => _basicinfoscreenState();
}

class _basicinfoscreenState extends State<basicinfoscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Card(
          child:Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: defaultPadding),

                const Center(child: Text("Basic Information",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                Divider(),
                const SizedBox(height: defaultPadding),


                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  cursorColor: kPrimaryColor,
                  onSaved: (email) {},
                  decoration: const InputDecoration(
                    hintText: "Full Name",
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
                      hintText: "Address-1",
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
                      hintText: "Address-2",
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
                      hintText: "Address-3",
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
                      hintText: "Country",
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
                      hintText: "State",
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
                      hintText: "City",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.lock),
                      ),

                    ),

                  ),
                ),


                const SizedBox(height: defaultPadding),
                Hero(
                  tag: "submit btn",
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
