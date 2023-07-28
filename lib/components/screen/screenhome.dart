import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gka/models/welcomejson.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<Result> result=[];
  bool loading=false;
  int off=0;
  bool visiblebtn=true;
  ScrollController scrollController=ScrollController();


  @override
  void initState() {
    super.initState();
    fetchData(off);
    handleNext();
  }



  void handleNext(){
    scrollController.addListener(() async{
      if(scrollController.position.maxScrollExtent ==
          scrollController.position.pixels){

        setState(() {
          loading=true;
        });
        fetchData(off);

      }
    });
  }

  Future<void>  fetchData(paraoffset) async{
    var url="http://e-gam.com/GKARESTAPI/welcomePage?off=${paraoffset}&lim=10";
    print(url);
    var uri=Uri.parse(url);
    var response=await http.get(uri);
    if(response.statusCode==200){
      Welcome welcome=Welcome.fromJson(json.decode(response.body));
      result=result + welcome.results;
      int localOffset=off+10;
      setState(() {
        result;
        loading=false;
        off=localOffset;
      });
    }
  }
  var status = 0;

  popupMenu(id){
    print(id);
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed:() {
                    Navigator.pop(context);

                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:ListView.builder(
        controller: scrollController,
        itemCount: loading ? result.length+1 : result.length,
        itemBuilder: (context, index) {
          if(index < result.length){
            return Card(
              shape: Border.all(color: Colors.grey),
              elevation: 8,
              child: InkWell(
                onTap: (){
                  popupMenu(result[index].id);
                },
                child: ListTile(
                  trailing:IconButton(icon: Icon(Icons.ads_click_sharp,),
                    onPressed: () {
                      popupMenu(result[index].id);
                    },),
                  contentPadding: EdgeInsets.all(5),
                  tileColor:  index % 2 == 0 ? Colors.white : Colors.white,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:NetworkImage("http://e-gam.com/GKA/Logo/GKA%20logo.jpg",),
                  ) ,
                  title: Text('${index + 1}',),
                  subtitle:Text(result[index].name),
                ),
              ),
            );
          }else{
            return const Center(child: CircularProgressIndicator(
              color: Colors.deepOrange,

            ));
          }
        },


      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          if (scrollController.hasClients) {
            final position = scrollController.position.minScrollExtent;
            scrollController.animateTo(
              position,
              duration: Duration(seconds: 1),
              curve: Curves.easeOut,
            );
          }
        },
        isExtended: true,

        tooltip: "Scroll to Bottom",
        child: Icon(Icons.arrow_circle_up),
      ),
    );
  }
}
