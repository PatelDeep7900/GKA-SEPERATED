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

                    child:Image.network("data:image/jpeg;base64,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"),
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
