import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class MyHomeApp extends StatefulWidget {
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Country State City Picker"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: CSCPicker(
              layout: Layout.vertical,
              flagState: CountryFlag.ENABLE,
              onCountryChanged: (value) {
                setState(() {
                 countryValue=value.toString();
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue=value.toString();
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue=value.toString();
                });
              },
              countryDropdownLabel: "*Country",
              stateDropdownLabel: "*State",
              cityDropdownLabel: "*City",
              dropdownDialogRadius: 30,
              searchBarRadius: 30,
            ),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  address = "$cityValue, $stateValue, $countryValue";
                });
                print(address);
              },
              child: Text("Print Data")),
        ],
      ),
    );
  }
}