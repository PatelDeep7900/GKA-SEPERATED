
import 'dart:convert';
class Welcome {
  bool? offcheck;
  bool? limcheck;
  int? aproveornot;
  List<Results>? results;
  bool? datafound;

  Welcome({this.offcheck, this.limcheck, this.results, this.datafound,this.aproveornot});

  Welcome.fromJson(Map<String, dynamic> json) {
    offcheck = json['offcheck'];
    limcheck = json['limcheck'];
    aproveornot=json['aproveornot'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    datafound = json['datafound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offcheck'] = this.offcheck;
    data['limcheck'] = this.limcheck;
    data['aproveornot'] = this.aproveornot;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['datafound'] = this.datafound;
    return data;
  }
}

class Results {
  String? userApprov;
  bool? cimgpathexists1;
  String? img1;


  String? strcities;
  String? mob;
  String? bDetail;
  String? address;
  String? email;
  String? parent;
  String? address1;
  String? sSanstha;
  String? natCity;
  String? strstate;
  String? aboutFamily;
  String? strpin;
  String? bLocation;
  String? sParents;
  String? phone;
  List<Familyinfo>? familyinfo;
  String? name;
  String? strcountry;
  String? bWebsite;
  String? id;
  String? ext2;
  String? ext1;
  String?imgapprove;

  Results(
      {this.userApprov,
        this.cimgpathexists1,
        this.img1,
        this.strcities,
        this.mob,
        this.bDetail,
        this.address,
        this.email,
        this.parent,
        this.address1,
        this.sSanstha,
        this.natCity,
        this.strstate,
        this.aboutFamily,
        this.strpin,
        this.bLocation,
        this.sParents,
        this.phone,
        this.familyinfo,
        this.name,
        this.strcountry,
        this.bWebsite,
        this.id,
        this.ext2,
        this.ext1,
        this.imgapprove
      });

  Results.fromJson(Map<String, dynamic> json) {
    userApprov = json['User_Approv'];
    cimgpathexists1=json['cimgpathexists1'];
    img1=json['img1'];
    strcities = json['strcities'];
    mob = json['Mob'];
    bDetail = json['B_Detail'];
    address = json['address'];
    email = json['Email'];
    parent = json['Parent'];
    address1 = json['address1'];
    sSanstha = json['s_sanstha'];
    natCity = json['Nat_City'];
    strstate = json['strstate'];
    aboutFamily = json['About_Family'];
    strpin = json['strpin'];
    bLocation = json['B_location'];
    sParents = json['S_Parents'];
    phone = json['Phone'];
    if (json['familyinfo'] != null) {
      familyinfo = <Familyinfo>[];
      json['familyinfo'].forEach((v) {
        familyinfo!.add(new Familyinfo.fromJson(v));
      });
    }
    name = json['name'];
    strcountry = json['strcountry'];
    bWebsite = json['B_Website'];
    id = json['id'];
    imgapprove = json['imgapprove'];
    ext2 = json['ext2'];
    ext1 = json['ext1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['User_Approv'] = this.userApprov;
    data['cimgpathexists1']=this.cimgpathexists1;
    data['img1']=this.img1;
    data['strcities'] = this.strcities;
    data['Mob'] = this.mob;
    data['B_Detail'] = this.bDetail;
    data['address'] = this.address;
    data['Email'] = this.email;
    data['Parent'] = this.parent;
    data['address1'] = this.address1;
    data['s_sanstha'] = this.sSanstha;
    data['Nat_City'] = this.natCity;
    data['strstate'] = this.strstate;
    data['About_Family'] = this.aboutFamily;
    data['strpin'] = this.strpin;
    data['B_location'] = this.bLocation;
    data['S_Parents'] = this.sParents;
    data['Phone'] = this.phone;
    if (this.familyinfo != null) {
      data['familyinfo'] = this.familyinfo!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['strcountry'] = this.strcountry;
    data['B_Website'] = this.bWebsite;
    data['id'] = this.id;
    data['imgapprove'] = this.imgapprove;
    data['ext2'] = this.ext2;
    data['ext1'] = this.ext1;
    return data;
  }
}

class Familyinfo {
  String? phone;
  String? dob;
  String? name;
  String? occ;
  String? email;
  String? relation;

  Familyinfo(
      {this.phone, this.dob, this.name, this.occ, this.email, this.relation});

  Familyinfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    dob = json['dob'];
    name = json['name'];
    occ = json['occ'];
    email = json['email'];
    relation = json['relation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['name'] = this.name;
    data['occ'] = this.occ;
    data['email'] = this.email;
    data['relation'] = this.relation;
    return data;
  }
}