import 'package:flutter/material.dart';
import 'package:gka/models/sponser.dart';

import 'package:icons_plus/icons_plus.dart';

class ContactPage extends StatelessWidget {
  ContactPage({super.key});

  List<Student> students = [
    Student(
        name: "Vinod Chauhan",
        email: "vchauhan2114@gmail.com",
        phone: "469-422-1503",
        desg: "President",
        contryname: "",
        homeno: ""),
    Student(
        name: "Harish Doolabh",
        email: "harrydoolabh@gmail.com",
        phone: "501-940-1576",
        desg: "Vice President",
        contryname: "",
        homeno: ""),
    Student(
        name: "Arun Arya",
        email: "arya.arun@gmail.com",
        phone: "714-875-8141",
        desg: "Public Relation",
        contryname: "",
        homeno: ""),
    Student(
        name: "Ravindra R. Parmar",
        email: "rparmar327@yahoo.com",
        phone: "912-202-2017",
        desg: "",
        contryname: "Jesup, GA",
        homeno: " 912-588-9555"),
    Student(
        name: "Paresh Pankhavala",
        email: "pankha@gmail.com",
        phone: " 252-626-5453",
        desg: "",
        contryname: "Newbern, NC",
        homeno: ""),
    Student(
        name: "Kanti R. Chavada",
        email: "kchavada@hotmail.com",
        phone: "740-297-5730",
        desg: "",
        contryname: "Columbus, Ohio",
        homeno: ""),
    Student(
        name: "Jayantibhai R. Chauhan",
        email: "ayanti2606@hotmail.com",
        phone: " 678-463-6075",
        desg: "",
        contryname: "Newnan, GA",
        homeno: "770-755-1568"),
    Student(
        name: "Kamlesh Chauhan",
        email: "kamlesh111@gmail.com",
        phone: "647-233-3296",
        desg: "CANADA",
        contryname: "Brampton, Ontario",
        homeno: "905-453-3296"),
    Student(
        name: "Jayantibhai Panchal",
        email: " jay.panchal@rogers.com",
        phone: "416-712-1004",
        desg: "",
        contryname: "Mississauga, Ontario",
        homeno: "905-507-2287"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Page'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ADMIN CONTACT',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xd9fd6d0c),
                    shadows: [Shadow(color: Colors.blueGrey, blurRadius: 10)]),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: students.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5),
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: double.maxFinite,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xd9fd6d0c),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              students[index].desg,
                              style: const TextStyle(
                                  color: Colors.blue, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              students[index].name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            students[index].contryname.isNotEmpty
                                ? Text(
                                    students[index].contryname,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const SizedBox(
                                    height: 5,
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesome.envelope, size: 14,color: Colors.red,),
                                SizedBox(width: 3,),
                                Text(students[index].email,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesome.phone, size: 14,color: Colors.blue,),
                                SizedBox(width: 3,),
                                Text(students[index].phone,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            students[index].homeno.isNotEmpty
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesome.phone, size: 14,color: Colors.blue,),
                                      SizedBox(width: 3,),
                                      Text(students[index].homeno,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14)),
                                    ],
                                  )
                                : const SizedBox(
                                    height: 1,
                                  ),
                          ],
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
