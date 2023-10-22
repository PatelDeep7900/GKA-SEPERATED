import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

int _id=0;
class basicinfopage extends StatefulWidget {
  const basicinfopage({Key? key}) : super(key: key);

  @override
  State<basicinfopage> createState() => _basicinfopageState();
}

class _basicinfopageState extends State<basicinfopage> {
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: BasicInfoPage(),

    );
  }
}
class BasicInfoPage extends StatefulWidget {
  const BasicInfoPage({Key? key}) : super(key: key);

  @override
  _BasicInfoPageState createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();

  final RoundedLoadingButtonController _btnController2 =
  RoundedLoadingButtonController();

  List countylist=[{"sortname":"SELECT","name":"SELECT","phonecode":"0","id":"0"},{"sortname":"AF","name":"Afghanistan","phonecode":"93","id":"1"},{"sortname":"AL","name":"Albania","phonecode":"355","id":"2"},{"sortname":"DZ","name":"Algeria","phonecode":"213","id":"3"},{"sortname":"AS","name":"American Samoa","phonecode":"1684","id":"4"},{"sortname":"AD","name":"Andorra","phonecode":"376","id":"5"},{"sortname":"AO","name":"Angola","phonecode":"244","id":"6"},{"sortname":"AI","name":"Anguilla","phonecode":"1264","id":"7"},{"sortname":"AQ","name":"Antarctica","phonecode":"0","id":"8"},{"sortname":"AG","name":"Antigua And Barbuda","phonecode":"1268","id":"9"},{"sortname":"AR","name":"Argentina","phonecode":"54","id":"10"},{"sortname":"AM","name":"Armenia","phonecode":"374","id":"11"},{"sortname":"AW","name":"Aruba","phonecode":"297","id":"12"},{"sortname":"AU","name":"Australia","phonecode":"61","id":"13"},{"sortname":"AT","name":"Austria","phonecode":"43","id":"14"},{"sortname":"AZ","name":"Azerbaijan","phonecode":"994","id":"15"},{"sortname":"BS","name":"Bahamas The","phonecode":"1242","id":"16"},{"sortname":"BH","name":"Bahrain","phonecode":"973","id":"17"},{"sortname":"BD","name":"Bangladesh","phonecode":"880","id":"18"},{"sortname":"BB","name":"Barbados","phonecode":"1246","id":"19"},{"sortname":"BY","name":"Belarus","phonecode":"375","id":"20"},{"sortname":"BE","name":"Belgium","phonecode":"32","id":"21"},{"sortname":"BZ","name":"Belize","phonecode":"501","id":"22"},{"sortname":"BJ","name":"Benin","phonecode":"229","id":"23"},{"sortname":"BM","name":"Bermuda","phonecode":"1441","id":"24"},{"sortname":"BT","name":"Bhutan","phonecode":"975","id":"25"},{"sortname":"BO","name":"Bolivia","phonecode":"591","id":"26"},{"sortname":"BA","name":"Bosnia and Herzegovina","phonecode":"387","id":"27"},{"sortname":"BW","name":"Botswana","phonecode":"267","id":"28"},{"sortname":"BV","name":"Bouvet Island","phonecode":"0","id":"29"},{"sortname":"BR","name":"Brazil","phonecode":"55","id":"30"},{"sortname":"IO","name":"British Indian Ocean Territory","phonecode":"246","id":"31"},{"sortname":"BN","name":"Brunei","phonecode":"673","id":"32"},{"sortname":"BG","name":"Bulgaria","phonecode":"359","id":"33"},{"sortname":"BF","name":"Burkina Faso","phonecode":"226","id":"34"},{"sortname":"BI","name":"Burundi","phonecode":"257","id":"35"},{"sortname":"KH","name":"Cambodia","phonecode":"855","id":"36"},{"sortname":"CM","name":"Cameroon","phonecode":"237","id":"37"},{"sortname":"CA","name":"Canada","phonecode":"1","id":"38"},{"sortname":"CV","name":"Cape Verde","phonecode":"238","id":"39"},{"sortname":"KY","name":"Cayman Islands","phonecode":"1345","id":"40"},{"sortname":"CF","name":"Central African Republic","phonecode":"236","id":"41"},{"sortname":"TD","name":"Chad","phonecode":"235","id":"42"},{"sortname":"CL","name":"Chile","phonecode":"56","id":"43"},{"sortname":"CN","name":"China","phonecode":"86","id":"44"},{"sortname":"CX","name":"Christmas Island","phonecode":"61","id":"45"},{"sortname":"CC","name":"Cocos (Keeling) Islands","phonecode":"672","id":"46"},{"sortname":"CO","name":"Colombia","phonecode":"57","id":"47"},{"sortname":"KM","name":"Comoros","phonecode":"269","id":"48"},{"sortname":"CK","name":"Cook Islands","phonecode":"682","id":"51"},{"sortname":"CR","name":"Costa Rica","phonecode":"506","id":"52"},{"sortname":"CI","name":"Cote D'Ivoire (Ivory Coast)","phonecode":"225","id":"53"},{"sortname":"HR","name":"Croatia (Hrvatska)","phonecode":"385","id":"54"},{"sortname":"CU","name":"Cuba","phonecode":"53","id":"55"},{"sortname":"CY","name":"Cyprus","phonecode":"357","id":"56"},{"sortname":"CZ","name":"Czech Republic","phonecode":"420","id":"57"},{"sortname":"CD","name":"Democratic Republic Of The Congo","phonecode":"242","id":"50"},{"sortname":"DK","name":"Denmark","phonecode":"45","id":"58"},{"sortname":"DJ","name":"Djibouti","phonecode":"253","id":"59"},{"sortname":"DM","name":"Dominica","phonecode":"1767","id":"60"},{"sortname":"DO","name":"Dominican Republic","phonecode":"1809","id":"61"},{"sortname":"TP","name":"East Timor","phonecode":"670","id":"62"},{"sortname":"EC","name":"Ecuador","phonecode":"593","id":"63"},{"sortname":"EG","name":"Egypt","phonecode":"20","id":"64"},{"sortname":"SV","name":"El Salvador","phonecode":"503","id":"65"},{"sortname":"GQ","name":"Equatorial Guinea","phonecode":"240","id":"66"},{"sortname":"ER","name":"Eritrea","phonecode":"291","id":"67"},{"sortname":"EE","name":"Estonia","phonecode":"372","id":"68"},{"sortname":"ET","name":"Ethiopia","phonecode":"251","id":"69"},{"sortname":"XA","name":"External Territories of Australia","phonecode":"61","id":"70"},{"sortname":"FK","name":"Falkland Islands","phonecode":"500","id":"71"},{"sortname":"FO","name":"Faroe Islands","phonecode":"298","id":"72"},{"sortname":"FJ","name":"Fiji Islands","phonecode":"679","id":"73"},{"sortname":"FI","name":"Finland","phonecode":"358","id":"74"},{"sortname":"FR","name":"France","phonecode":"33","id":"75"},{"sortname":"GF","name":"French Guiana","phonecode":"594","id":"76"},{"sortname":"PF","name":"French Polynesia","phonecode":"689","id":"77"},{"sortname":"TF","name":"French Southern Territories","phonecode":"0","id":"78"},{"sortname":"GA","name":"Gabon","phonecode":"241","id":"79"},{"sortname":"GM","name":"Gambia The","phonecode":"220","id":"80"},{"sortname":"GE","name":"Georgia","phonecode":"995","id":"81"},{"sortname":"DE","name":"Germany","phonecode":"49","id":"82"},{"sortname":"GH","name":"Ghana","phonecode":"233","id":"83"},{"sortname":"GI","name":"Gibraltar","phonecode":"350","id":"84"},{"sortname":"GR","name":"Greece","phonecode":"30","id":"85"},{"sortname":"GL","name":"Greenland","phonecode":"299","id":"86"},{"sortname":"GD","name":"Grenada","phonecode":"1473","id":"87"},{"sortname":"GP","name":"Guadeloupe","phonecode":"590","id":"88"},{"sortname":"GU","name":"Guam","phonecode":"1671","id":"89"},{"sortname":"GT","name":"Guatemala","phonecode":"502","id":"90"},{"sortname":"XU","name":"Guernsey and Alderney","phonecode":"44","id":"91"},{"sortname":"GN","name":"Guinea","phonecode":"224","id":"92"},{"sortname":"GW","name":"Guinea-Bissau","phonecode":"245","id":"93"},{"sortname":"GY","name":"Guyana","phonecode":"592","id":"94"},{"sortname":"HT","name":"Haiti","phonecode":"509","id":"95"},{"sortname":"HM","name":"Heard and McDonald Islands","phonecode":"0","id":"96"},{"sortname":"HN","name":"Honduras","phonecode":"504","id":"97"},{"sortname":"HK","name":"Hong Kong S.A.R.","phonecode":"852","id":"98"},{"sortname":"HU","name":"Hungary","phonecode":"36","id":"99"},{"sortname":"IS","name":"Iceland","phonecode":"354","id":"100"},{"sortname":"IN","name":"India","phonecode":"91","id":"101"},{"sortname":"ID","name":"Indonesia","phonecode":"62","id":"102"},{"sortname":"IR","name":"Iran","phonecode":"98","id":"103"},{"sortname":"IQ","name":"Iraq","phonecode":"964","id":"104"},{"sortname":"IE","name":"Ireland","phonecode":"353","id":"105"},{"sortname":"IL","name":"Israel","phonecode":"972","id":"106"},{"sortname":"IT","name":"Italy","phonecode":"39","id":"107"},{"sortname":"JM","name":"Jamaica","phonecode":"1876","id":"108"},{"sortname":"JP","name":"Japan","phonecode":"81","id":"109"},{"sortname":"XJ","name":"Jersey","phonecode":"44","id":"110"},{"sortname":"JO","name":"Jordan","phonecode":"962","id":"111"},{"sortname":"KZ","name":"Kazakhstan","phonecode":"7","id":"112"},{"sortname":"KE","name":"Kenya","phonecode":"254","id":"113"},{"sortname":"KI","name":"Kiribati","phonecode":"686","id":"114"},{"sortname":"KP","name":"Korea North","phonecode":"850","id":"115"},{"sortname":"KR","name":"Korea South","phonecode":"82","id":"116"},{"sortname":"KW","name":"Kuwait","phonecode":"965","id":"117"},{"sortname":"KG","name":"Kyrgyzstan","phonecode":"996","id":"118"},{"sortname":"LA","name":"Laos","phonecode":"856","id":"119"},{"sortname":"LV","name":"Latvia","phonecode":"371","id":"120"},{"sortname":"LB","name":"Lebanon","phonecode":"961","id":"121"},{"sortname":"LS","name":"Lesotho","phonecode":"266","id":"122"},{"sortname":"LR","name":"Liberia","phonecode":"231","id":"123"},{"sortname":"LY","name":"Libya","phonecode":"218","id":"124"},{"sortname":"LI","name":"Liechtenstein","phonecode":"423","id":"125"},{"sortname":"LT","name":"Lithuania","phonecode":"370","id":"126"},{"sortname":"LU","name":"Luxembourg","phonecode":"352","id":"127"},{"sortname":"MO","name":"Macau S.A.R.","phonecode":"853","id":"128"},{"sortname":"MK","name":"Macedonia","phonecode":"389","id":"129"},{"sortname":"MG","name":"Madagascar","phonecode":"261","id":"130"},{"sortname":"MW","name":"Malawi","phonecode":"265","id":"131"},{"sortname":"MY","name":"Malaysia","phonecode":"60","id":"132"},{"sortname":"MV","name":"Maldives","phonecode":"960","id":"133"},{"sortname":"ML","name":"Mali","phonecode":"223","id":"134"},{"sortname":"MT","name":"Malta","phonecode":"356","id":"135"},{"sortname":"XM","name":"Man (Isle of)","phonecode":"44","id":"136"},{"sortname":"MH","name":"Marshall Islands","phonecode":"692","id":"137"},{"sortname":"MQ","name":"Martinique","phonecode":"596","id":"138"},{"sortname":"MR","name":"Mauritania","phonecode":"222","id":"139"},{"sortname":"MU","name":"Mauritius","phonecode":"230","id":"140"},{"sortname":"YT","name":"Mayotte","phonecode":"269","id":"141"},{"sortname":"MX","name":"Mexico","phonecode":"52","id":"142"},{"sortname":"FM","name":"Micronesia","phonecode":"691","id":"143"},{"sortname":"MD","name":"Moldova","phonecode":"373","id":"144"},{"sortname":"MC","name":"Monaco","phonecode":"377","id":"145"},{"sortname":"MN","name":"Mongolia","phonecode":"976","id":"146"},{"sortname":"MS","name":"Montserrat","phonecode":"1664","id":"147"},{"sortname":"MA","name":"Morocco","phonecode":"212","id":"148"},{"sortname":"MZ","name":"Mozambique","phonecode":"258","id":"149"},{"sortname":"MM","name":"Myanmar","phonecode":"95","id":"150"},{"sortname":"NA","name":"Namibia","phonecode":"264","id":"151"},{"sortname":"NR","name":"Nauru","phonecode":"674","id":"152"},{"sortname":"NP","name":"Nepal","phonecode":"977","id":"153"},{"sortname":"AN","name":"Netherlands Antilles","phonecode":"599","id":"154"},{"sortname":"NL","name":"Netherlands The","phonecode":"31","id":"155"},{"sortname":"NC","name":"New Caledonia","phonecode":"687","id":"156"},{"sortname":"NZ","name":"New Zealand","phonecode":"64","id":"157"},{"sortname":"NI","name":"Nicaragua","phonecode":"505","id":"158"},{"sortname":"NE","name":"Niger","phonecode":"227","id":"159"},{"sortname":"NG","name":"Nigeria","phonecode":"234","id":"160"},{"sortname":"NU","name":"Niue","phonecode":"683","id":"161"},{"sortname":"NF","name":"Norfolk Island","phonecode":"672","id":"162"},{"sortname":"MP","name":"Northern Mariana Islands","phonecode":"1670","id":"163"},{"sortname":"NO","name":"Norway","phonecode":"47","id":"164"},{"sortname":"OM","name":"Oman","phonecode":"968","id":"165"},{"sortname":"PK","name":"Pakistan","phonecode":"92","id":"166"},{"sortname":"PW","name":"Palau","phonecode":"680","id":"167"},{"sortname":"PS","name":"Palestinian Territory Occupied","phonecode":"970","id":"168"},{"sortname":"PA","name":"Panama","phonecode":"507","id":"169"},{"sortname":"PG","name":"Papua new Guinea","phonecode":"675","id":"170"},{"sortname":"PY","name":"Paraguay","phonecode":"595","id":"171"},{"sortname":"PE","name":"Peru","phonecode":"51","id":"172"},{"sortname":"PH","name":"Philippines","phonecode":"63","id":"173"},{"sortname":"PN","name":"Pitcairn Island","phonecode":"0","id":"174"},{"sortname":"PL","name":"Poland","phonecode":"48","id":"175"},{"sortname":"PT","name":"Portugal","phonecode":"351","id":"176"},{"sortname":"PR","name":"Puerto Rico","phonecode":"1787","id":"177"},{"sortname":"QA","name":"Qatar","phonecode":"974","id":"178"},{"sortname":"CG","name":"Republic Of The Congo","phonecode":"242","id":"49"},{"sortname":"RE","name":"Reunion","phonecode":"262","id":"179"},{"sortname":"RO","name":"Romania","phonecode":"40","id":"180"},{"sortname":"RU","name":"Russia","phonecode":"70","id":"181"},{"sortname":"RW","name":"Rwanda","phonecode":"250","id":"182"},{"sortname":"SH","name":"Saint Helena","phonecode":"290","id":"183"},{"sortname":"KN","name":"Saint Kitts And Nevis","phonecode":"1869","id":"184"},{"sortname":"LC","name":"Saint Lucia","phonecode":"1758","id":"185"},{"sortname":"PM","name":"Saint Pierre and Miquelon","phonecode":"508","id":"186"},{"sortname":"VC","name":"Saint Vincent And The Grenadines","phonecode":"1784","id":"187"},{"sortname":"WS","name":"Samoa","phonecode":"684","id":"188"},{"sortname":"SM","name":"San Marino","phonecode":"378","id":"189"},{"sortname":"ST","name":"Sao Tome and Principe","phonecode":"239","id":"190"},{"sortname":"SA","name":"Saudi Arabia","phonecode":"966","id":"191"},{"sortname":"SN","name":"Senegal","phonecode":"221","id":"192"},{"sortname":"RS","name":"Serbia","phonecode":"381","id":"193"},{"sortname":"SC","name":"Seychelles","phonecode":"248","id":"194"},{"sortname":"SL","name":"Sierra Leone","phonecode":"232","id":"195"},{"sortname":"SG","name":"Singapore","phonecode":"65","id":"196"},{"sortname":"SK","name":"Slovakia","phonecode":"421","id":"197"},{"sortname":"SI","name":"Slovenia","phonecode":"386","id":"198"},{"sortname":"XG","name":"Smaller Territories of the UK","phonecode":"44","id":"199"},{"sortname":"SB","name":"Solomon Islands","phonecode":"677","id":"200"},{"sortname":"SO","name":"Somalia","phonecode":"252","id":"201"},{"sortname":"ZA","name":"South Africa","phonecode":"27","id":"202"},{"sortname":"GS","name":"South Georgia","phonecode":"0","id":"203"},{"sortname":"SS","name":"South Sudan","phonecode":"211","id":"204"},{"sortname":"ES","name":"Spain","phonecode":"34","id":"205"},{"sortname":"LK","name":"Sri Lanka","phonecode":"94","id":"206"},{"sortname":"SD","name":"Sudan","phonecode":"249","id":"207"},{"sortname":"SR","name":"Suriname","phonecode":"597","id":"208"},{"sortname":"SJ","name":"Svalbard And Jan Mayen Islands","phonecode":"47","id":"209"},{"sortname":"SZ","name":"Swaziland","phonecode":"268","id":"210"},{"sortname":"SE","name":"Sweden","phonecode":"46","id":"211"},{"sortname":"CH","name":"Switzerland","phonecode":"41","id":"212"},{"sortname":"SY","name":"Syria","phonecode":"963","id":"213"},{"sortname":"TW","name":"Taiwan","phonecode":"886","id":"214"},{"sortname":"TJ","name":"Tajikistan","phonecode":"992","id":"215"},{"sortname":"TZ","name":"Tanzania","phonecode":"255","id":"216"},{"sortname":"TH","name":"Thailand","phonecode":"66","id":"217"},{"sortname":"TG","name":"Togo","phonecode":"228","id":"218"},{"sortname":"TK","name":"Tokelau","phonecode":"690","id":"219"},{"sortname":"TO","name":"Tonga","phonecode":"676","id":"220"},{"sortname":"TT","name":"Trinidad And Tobago","phonecode":"1868","id":"221"},{"sortname":"TN","name":"Tunisia","phonecode":"216","id":"222"},{"sortname":"TR","name":"Turkey","phonecode":"90","id":"223"},{"sortname":"TM","name":"Turkmenistan","phonecode":"7370","id":"224"},{"sortname":"TC","name":"Turks And Caicos Islands","phonecode":"1649","id":"225"},{"sortname":"TV","name":"Tuvalu","phonecode":"688","id":"226"},{"sortname":"UG","name":"Uganda","phonecode":"256","id":"227"},{"sortname":"UA","name":"Ukraine","phonecode":"380","id":"228"},{"sortname":"AE","name":"United Arab Emirates","phonecode":"971","id":"229"},{"sortname":"GB","name":"United Kingdom","phonecode":"44","id":"230"},{"sortname":"US","name":"United States","phonecode":"1","id":"231"},{"sortname":"UM","name":"United States Minor Outlying Islands","phonecode":"1","id":"232"},{"sortname":"UY","name":"Uruguay","phonecode":"598","id":"233"},{"sortname":"UZ","name":"Uzbekistan","phonecode":"998","id":"234"},{"sortname":"VU","name":"Vanuatu","phonecode":"678","id":"235"},{"sortname":"VA","name":"Vatican City State (Holy See)","phonecode":"39","id":"236"},{"sortname":"VE","name":"Venezuela","phonecode":"58","id":"237"},{"sortname":"VN","name":"Vietnam","phonecode":"84","id":"238"},{"sortname":"VG","name":"Virgin Islands (British)","phonecode":"1284","id":"239"},{"sortname":"VI","name":"Virgin Islands (US)","phonecode":"1340","id":"240"},{"sortname":"WF","name":"Wallis And Futuna Islands","phonecode":"681","id":"241"},{"sortname":"EH","name":"Western Sahara","phonecode":"212","id":"242"},{"sortname":"YE","name":"Yemen","phonecode":"967","id":"243"},{"sortname":"YU","name":"Yugoslavia","phonecode":"38","id":"244"},{"sortname":"ZM","name":"Zambia","phonecode":"260","id":"245"},{"sortname":"ZW","name":"Zimbabwe","phonecode":"263","id":"246"}];
  List statelist=[{"name":"SELECT","id":"0"}];
  List citylist=[{"name":"SELECT","id":"0"}];
  List defaultlist=[{"name":"SELECT","id":"0"}];


  String dropdownValuecountry = '0';
  String dropdownValuestate = '0';
  String dropdownValuecity = '0';



  TextEditingController nameController = TextEditingController();
  TextEditingController add1Controller = TextEditingController();
  TextEditingController add2Controller = TextEditingController();

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _id = (prefs.getInt('id') ?? 0);
    });
  }

  void basicinfoput(int userid) async{
    String url="http://e-gam.com/GKARESTAPI/userdata";
    Response response=await post(
        Uri.parse(url),
        body:
        {
          'userid':userid.toString()
        }
    );
    if(response.statusCode==200) {
      var data = jsonDecode(response.body.toString());

      String db_country=data['basicData'][0]['Country'].toString();
      String db_state=data['basicData'][0]['State'].toString();
      String db_city=data['basicData'][0]['City'].toString();


      setState(()
      {
        nameController.text = data['basicData'][0]['Name'].toString();
        add1Controller.text = data['basicData'][0]['Address'].toString();
        add2Controller.text = data['basicData'][0]['Address1'].toString();



      });
      loadstatecityget(db_country,db_state,db_city);




    }
  }


  void loadstatecityget(String Country_Id,String State_Id,String City_Id) async{
    String url="http://e-gam.com/GKARESTAPI/AllGet?Country_Id="+Country_Id+"&State_Id="+State_Id;
    Response response=await get(
      Uri.parse(url),
    );
    if(response.statusCode==200) {
      var data = jsonDecode(response.body.toString());
      setState(() {
        statelist=data['StateData'];
        citylist=data['CityData'];
        dropdownValuecountry=Country_Id;
        dropdownValuestate=State_Id;
        dropdownValuecity=City_Id;
      });
    }
  }






  void stateget(String Country_Id) async{

    if(Country_Id=="0"){
      setState(() {
        statelist=defaultlist;
        citylist=defaultlist;
        dropdownValuestate="0";
        dropdownValuecity="0";
      });
    }else{

      String url = "http://e-gam.com/GKARESTAPI/Countryget?type=State";
      Response response = await post(
          Uri.parse(url),
          body: {
            "type": "State",
            "Country_Id": Country_Id
          }


      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        setState(() {
          statelist=data;
          citylist=defaultlist;
          dropdownValuestate="0";
          dropdownValuecity="0";
        });

      }


    }
  }



  void cityget(String State_Id) async{
    if(State_Id=="0"){
      setState(() {
        citylist=defaultlist;
        dropdownValuecity="0";
      });
    }else{
      String url = "http://e-gam.com/GKARESTAPI/Countryget";
      Response response = await post(
          Uri.parse(url),
          body: {
            "type": "City",
            "State_Id": State_Id
          }
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        setState(() {
          citylist=data;
          dropdownValuecity="0";
        });
      }
    }
  }


  Future<void> updatebasicinfo(List data) async {

    String Name=data[0];
    String Address=data[1];
    String Address1=data[2];
    String Country=data[3];
    String State=data[4];
    String City=data[5];

    String url = "http://e-gam.com/GKARESTAPI/CrudOperation";
    Response response = await post(
        Uri.parse(url),
        body: {
          "type": "BI",
          "Name": Name,
          "Address": Address,
          "Address1": Address1,
          "Country": Country,
          "State": State,
          "City": City,
          "userid":_id.toString()
        }

    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      if(data['result']==true){
        _btnController1.success();
      }else{
        _btnController1.error();
      }

    }else{
      _btnController1.error();
    }

    Timer(Duration(seconds: 1), () {
      _btnController1.reset();
    });

  }

  @override
  initState() {



    Timer(Duration(seconds: 1), () {
      _loadCounter();

    });

    Timer(Duration(seconds: 2), () {

      basicinfoput(_id);
    });




  }









  _basicinfobuildTest()   {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: false,
        children: [
          Text("Basic Information",style: TextStyle(
            decoration: TextDecoration.none,
            color: Colors.blue,
            fontSize: 25,
          ),),

          Divider(color: Colors.black),

          const SizedBox(
            height: 20,
          ),




          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Name',
              labelText: 'Name',

            ),
          ),
          //some space between name and email

          const SizedBox(
            height: 20,
          ),



          TextField(
            controller: add1Controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Address-1',
              labelText: 'Address-1',

            ),
          ),
          //some space between name

          const SizedBox(
            height: 20,
          ),


          TextField(
            controller: add2Controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Address-2',
              labelText: 'Address-2',

            ),
          ),
          //some space between name

          const SizedBox(
            height: 20,
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white.withOpacity(0.5)
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: DropdownButton<String>(
                value: dropdownValuecountry,
                icon: const Icon(Icons.arrow_drop_down_outlined),
                elevation: 16,
                underline: Container(
                  height: 0,
                ),
                style: const TextStyle(color: Colors.black,fontSize: 16),
                onChanged: (String? country)
                {


                  stateget(country!);

                  setState(() {
                    dropdownValuecountry = country!;

                  });


                },
                items: countylist.map((country) {
                  return DropdownMenuItem(
                    value: country['id'].toString(),
                    child: Text(country['name'].toString()),
                  );
                }).toList(),

              ),
            ),

          ),

          const SizedBox(
            height: 20,
          ),

          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: dropdownValuestate,
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black,fontSize: 16),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? state) {

                    cityget(state!);

                    setState(() {
                      dropdownValuestate = state!;
                    });
                  },
                  items: statelist.map((state) {
                    return DropdownMenuItem(
                      value: state['id'].toString(),
                      child: Text(state['name'].toString()),
                    );
                  }).toList(),
                ),
              )

          ),



          const SizedBox(
            height: 20,
          ),

          Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton<String>(
                  value: dropdownValuecity,
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  elevation: 16,
                  style: const TextStyle(color: Colors.black,fontSize: 16),
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? city) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValuecity = city!;
                    });
                  },
                  items: citylist.map((city) {
                    return DropdownMenuItem(
                      value: city['id'].toString(),
                      child: Text(city['name'].toString()),
                    );
                  }).toList(),
                ),
              )

          ),


          const SizedBox(
            height: 20,
          ),






          RoundedLoadingButton(
            successIcon: Icons.check_box,

            failedIcon: Icons.close,
            successColor: Colors.green,
            errorColor: Colors.red,
            child: const Text('Submit', style: TextStyle(color: Colors.white)),
            controller: _btnController1,
            onPressed: () {

              List data=[];

              data.add(nameController.text.toString());
              data.add(add1Controller.text.toString());
              data.add(add2Controller.text.toString());
              data.add(dropdownValuecountry);
              data.add(dropdownValuestate);
              data.add(dropdownValuecity);
              updatebasicinfo(data);


            },
          ),
          const SizedBox(
            height: 20,
          ),

          RoundedLoadingButton(
            successIcon: Icons.check_box,

            failedIcon: Icons.close,
            successColor: Colors.green,
            errorColor: Colors.red,
            child: Text('Reset', style: TextStyle(color: Colors.white)),
            controller: _btnController2,
            onPressed: () {

              basicinfoput(_id);
              _btnController2.success();

              Timer(Duration(seconds: 1), () {
                _btnController2.stop();
              });

            },
          ),


        ],

      ),


    );



  }



  @override
  Widget build(BuildContext context){

    return _basicinfobuildTest();
  }
}