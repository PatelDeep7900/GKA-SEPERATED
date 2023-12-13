import 'dart:convert';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gka/constants.dart';
import 'package:gka/models/drawermodel/familyinfomodel/familyinfo.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class familyinfoscreen extends StatefulWidget {
  const familyinfoscreen({Key? key}) : super(key: key);

  @override
  State<familyinfoscreen> createState() => _HomePageState();
}

class _HomePageState extends State<familyinfoscreen> {
  final _formkey = GlobalKey<FormState>();

  List<familyinfo> _items = [];
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _spouseController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _desgController = TextEditingController();
  final TextEditingController _mobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> getfamilyinfoall() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_familyinformation';
      final response =
          await http.post(Uri.parse(url), body: {'id': id.toString()});
      if (response.statusCode == 200) {
        setState(() {
          List<familyinfo> welcome =
              familyinfo.fromJsonList(json.decode(response.body));
          _items = welcome;
        });
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }

  Future<void> insertfamily() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_familyinfoupdate';
      final response = await http.post(Uri.parse(url), body: {
        'cond': 'insert',
        'id': id.toString(),
        'Name': _nameController.text,
        'Relation': _spouseController.text,
        'Dob': _dobController.text,
        'Occupation': _desgController.text,
        'Phone': _mobController.text,
        'Email': _emailController.text,
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool result = data['result'];
        if (result == true) {
          getfamilyinfoall();

          _nameController.text = "";
          _spouseController.text = "";
          _dobController.text = "";
          _desgController.text = "";
          _mobController.text = "";
          _emailController.text = "";
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Insert Data Successfully...'))); // Close th
        } else {
          print("not saved data");
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }

  Future<void> update(int Auto_no, int itemKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");

    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_familyinfoupdate';
      final response = await http.post(Uri.parse(url), body: {
        'cond': 'update',
        'id': id.toString(),
        'Name': _nameController.text,
        'Relation': _spouseController.text,
        'Dob': _dobController.text,
        'Occupation': _desgController.text,
        'Phone': _mobController.text,
        'Email': _emailController.text,
        'Auto_no': Auto_no.toString()
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool result = data['result'];
        if (result == true) {
          _items[itemKey].name = _nameController.text;
          _items[itemKey].relation = _spouseController.text;
          _items[itemKey].dob = _dobController.text;
          _items[itemKey].occ = _desgController.text;
          _items[itemKey].phone = _mobController.text;
          _items[itemKey].email = _emailController.text;

          getfamilyinfoall();

          _nameController.text = "";
          _spouseController.text = "";
          _dobController.text = "";
          _desgController.text = "";
          _mobController.text = "";
          _emailController.text = "";

          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Update Data Successfully...')));

          Navigator.of(context).pop(); //
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error While Updating Data')));
          print("not saved data");
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }

  Future<void> deletefamily(int Auto_no, int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt("id");
    try {
      String url = 'http://e-gam.com/GKARESTAPI/c_familyinfoupdate';
      final response = await http.post(Uri.parse(url), body: {
        'cond': 'delete',
        'Auto_no': Auto_no.toString(),
        'id': id.toString()
      });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        bool result = data['result'];
        if (result == true) {
          getfamilyinfoall();
        } else {
          print("not saved data");
        }
      }
    } on Exception catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Server not Responding')));
      print('error caught: $e');
      rethrow;
    }
  }

  void _showForm(BuildContext ctx, int? itemKey) async {
    if (itemKey != null) {
      _nameController.text = _items[itemKey].name!;
      _spouseController.text = _items[itemKey].relation!;
      _dobController.text = _items[itemKey].dob!;
      _desgController.text = _items[itemKey].occ!;
      _mobController.text = _items[itemKey].phone!;
      _emailController.text = _items[itemKey].email!;
    } else {
      _nameController.text = "";
      _spouseController.text = "";
      _dobController.text = "";
      _desgController.text = "";
      _mobController.text = "";
      _emailController.text = "";
    }

    showModalBottomSheet(
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        context: ctx,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              decoration: BoxDecoration(
                color: Colors.white30,
              ),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                  top: 15,
                  left: 15,
                  right: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       InkWell(child: Icon(Icons.arrow_back),onTap: () {
                         Navigator.pop(context);
                       },),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                              hintText: 'Name',
                              label: Chip(label: Text('Name')),
                              prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.person),
                            ),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter name';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller: _spouseController,
                          decoration: const InputDecoration(
                            hintText: 'self/Spouse/Child',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.group_outlined),
                            ),
                            label: Chip(label: Text('self/Spouse/Child')),
                          ),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Please enter relation';
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller:
                              _dobController, //editing controller of this TextField
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            hintText: "Date Of Birth",
                            label: Chip(label: Text('Date Of Birth')),
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              setState(() {
                                _dobController.text = formattedDate;
                              });
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller: _desgController,
                          decoration: const InputDecoration(
                            hintText: 'Occupation',
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.work),
                            ),
                            label: Chip(label: Text('Occupation')),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller: _mobController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: 'Mobile',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.phone),
                              ),
                              label: Chip(label: Text('Mobile'))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintText: 'Email Address',
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.email),
                              ),
                              label: Chip(label: Text('Email Address'))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final validate = _formkey.currentState?.validate();
                          if (validate!) {
                            if (itemKey == null) {
                              insertfamily();
                            } else {
                              update(_items[itemKey].Auto_no!, itemKey);
                            }
                          }
                        },
                        child: Text(itemKey == null ? 'Create New' : 'Update'),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  void initState() {
    getfamilyinfoall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Family Information',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: const Chip(
                label: Row(
                  children: [
                    Text(
                      'add',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.add)
                  ],
                ),
                backgroundColor: Colors.green,
              ),
              onTap: () {
                _showForm(context, null);
              },
            ),
          )
        ],
      ),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No Family Information Please Click On (+) button on Top right side',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              // the list of items
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  margin: const EdgeInsets.all(5),
                  elevation: 6,
                  child: ListTile(
                      title: Text(currentItem.name!),
                      subtitle: Text(currentItem.relation!),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Edit button
                          IconButton(
                              icon: const Icon(Icons.edit),
                              color: Colors.green,
                              onPressed: () => _showForm(context, index)),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            onPressed: () async {
                              if (await confirm(context)) {
                                deletefamily(_items[index].Auto_no!, index);
                              }
                              return print('pressedCancel');
                            },
                            // onPressed: () => _deleteItem(currentItem['key']),
                          ),
                        ],
                      )),
                );
              }),
    );
  }
}
