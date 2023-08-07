// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool offcheck;
  bool limcheck;
  List<Result> results;
  bool datafound;

  Welcome({
    required this.offcheck,
    required this.limcheck,
    required this.results,
    required this.datafound,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    offcheck: json["offcheck"],
    limcheck: json["limcheck"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    datafound: json["datafound"],
  );

  Map<String, dynamic> toJson() => {
    "offcheck": offcheck,
    "limcheck": limcheck,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "datafound": datafound,
  };
}

class Result {
  String userApprov;
  Strcities strcities;
  String mob;
  BDetail bDetail;
  String address;
  String email;
  String parent;
  String address1;
  String sSanstha;
  String natCity;
  Strstate strstate;
  String aboutFamily;
  String strpin;
  BLocation bLocation;
  String sParents;
  String phone;
  List<Familyinfo> familyinfo;
  String name;
  Strcountry strcountry;
  BWebsite bWebsite;
  String id;
  String ext2;
  Ext1 ext1;

  Result({
    required this.userApprov,
    required this.strcities,
    required this.mob,
    required this.bDetail,
    required this.address,
    required this.email,
    required this.parent,
    required this.address1,
    required this.sSanstha,
    required this.natCity,
    required this.strstate,
    required this.aboutFamily,
    required this.strpin,
    required this.bLocation,
    required this.sParents,
    required this.phone,
    required this.familyinfo,
    required this.name,
    required this.strcountry,
    required this.bWebsite,
    required this.id,
    required this.ext2,
    required this.ext1,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userApprov: json["User_Approv"],
    strcities: strcitiesValues.map[json["strcities"]]!,
    mob: json["Mob"],
    bDetail: bDetailValues.map[json["B_Detail"]]!,
    address: json["address"],
    email: json["Email"],
    parent: json["Parent"],
    address1: json["address1"],
    sSanstha: json["s_sanstha"],
    natCity: json["Nat_City"],
    strstate: strstateValues.map[json["strstate"]]!,
    aboutFamily: json["About_Family"],
    strpin: json["strpin"],
    bLocation: bLocationValues.map[json["B_location"]]!,
    sParents: json["S_Parents"],
    phone: json["Phone"],
    familyinfo: List<Familyinfo>.from(json["familyinfo"].map((x) => Familyinfo.fromJson(x))),
    name: json["name"],
    strcountry: strcountryValues.map[json["strcountry"]]!,
    bWebsite: bWebsiteValues.map[json["B_Website"]]!,
    id: json["id"],
    ext2: json["ext2"],
    ext1: ext1Values.map[json["ext1"]]!,
  );

  Map<String, dynamic> toJson() => {
    "User_Approv": userApprov,
    "strcities": strcitiesValues.reverse[strcities],
    "Mob": mob,
    "B_Detail": bDetailValues.reverse[bDetail],
    "address": address,
    "Email": email,
    "Parent": parent,
    "address1": address1,
    "s_sanstha": sSanstha,
    "Nat_City": natCity,
    "strstate": strstateValues.reverse[strstate],
    "About_Family": aboutFamily,
    "strpin": strpin,
    "B_location": bLocationValues.reverse[bLocation],
    "S_Parents": sParents,
    "Phone": phone,
    "familyinfo": List<dynamic>.from(familyinfo.map((x) => x.toJson())),
    "name": name,
    "strcountry": strcountryValues.reverse[strcountry],
    "B_Website": bWebsiteValues.reverse[bWebsite],
    "id": id,
    "ext2": ext2,
    "ext1": ext1Values.reverse[ext1],
  };
}

enum BDetail {
  EMPTY,
  IT,
  TESTING_ONLY
}

final bDetailValues = EnumValues({
  "": BDetail.EMPTY,
  "it": BDetail.IT,
  "testing only": BDetail.TESTING_ONLY
});

enum BLocation {
  EMPTY,
  SURAT001,
  SURAT_KIM
}

final bLocationValues = EnumValues({
  "": BLocation.EMPTY,
  "surat001": BLocation.SURAT001,
  "surat kim": BLocation.SURAT_KIM
});

enum BWebsite {
  EMPTY,
  NIRMALPATEL0531_GMAIL_COM,
  WWW_DEMO_ORG
}

final bWebsiteValues = EnumValues({
  "": BWebsite.EMPTY,
  "nirmalpatel0531@gmail.com": BWebsite.NIRMALPATEL0531_GMAIL_COM,
  "www.demo.org": BWebsite.WWW_DEMO_ORG
});

enum Ext1 {
  BARDOLI,
  EMPTY
}

final ext1Values = EnumValues({
  "Bardoli": Ext1.BARDOLI,
  "": Ext1.EMPTY
});

class Familyinfo {
  String phone;
  String dob;
  String name;
  Occ occ;
  String email;
  String relation;

  Familyinfo({
    required this.phone,
    required this.dob,
    required this.name,
    required this.occ,
    required this.email,
    required this.relation,
  });

  factory Familyinfo.fromJson(Map<String, dynamic> json) => Familyinfo(
    phone: json["phone"],
    dob: json["dob"],
    name: json["name"],
    occ: occValues.map[json["occ"]]!,
    email: json["email"],
    relation: json["relation"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "dob": dob,
    "name": name,
    "occ": occValues.reverse[occ],
    "email": email,
    "relation": relation,
  };
}

enum Occ {
  BUSINESS,
  ELECTRIC_ENGINEER,
  EMPTY,
  HOUSEWIFE,
  IT_ENGINEER,
  RETIRED,
  STUDENT
}

final occValues = EnumValues({
  "Business": Occ.BUSINESS,
  "Electric Engineer": Occ.ELECTRIC_ENGINEER,
  "": Occ.EMPTY,
  "Housewife": Occ.HOUSEWIFE,
  "IT Engineer": Occ.IT_ENGINEER,
  "Retired ": Occ.RETIRED,
  "student": Occ.STUDENT
});

enum Strcities {
  BEACH,
  BREWTON,
  COLUMBUS,
  CUMMING,
  EDISON,
  KENNER,
  LITTLE_ROCK,
  LYNNWOOD,
  NEWNAN,
  NEW_BERN,
  SELECT,
  WEST_COLUMBIA
}

final strcitiesValues = EnumValues({
  "Beach": Strcities.BEACH,
  "Brewton": Strcities.BREWTON,
  "Columbus": Strcities.COLUMBUS,
  "Cumming": Strcities.CUMMING,
  "Edison": Strcities.EDISON,
  "Kenner": Strcities.KENNER,
  "Little Rock": Strcities.LITTLE_ROCK,
  "Lynnwood": Strcities.LYNNWOOD,
  "Newnan": Strcities.NEWNAN,
  "New Bern": Strcities.NEW_BERN,
  "SELECT": Strcities.SELECT,
  "West Columbia": Strcities.WEST_COLUMBIA
});

enum Strcountry {
  CANADA,
  UNITED_STATES
}

final strcountryValues = EnumValues({
  "Canada": Strcountry.CANADA,
  "United States": Strcountry.UNITED_STATES
});

enum Strstate {
  ALABAMA,
  ARKANSAS,
  FLORIDA,
  GEORGIA,
  LOUISIANA,
  NEW_JERSEY,
  NORTH_CAROLINA,
  OHIO,
  SELECT,
  SOUTH_CAROLINA,
  WASHINGTON
}

final strstateValues = EnumValues({
  "Alabama": Strstate.ALABAMA,
  "Arkansas": Strstate.ARKANSAS,
  "Florida": Strstate.FLORIDA,
  "Georgia": Strstate.GEORGIA,
  "Louisiana": Strstate.LOUISIANA,
  "New Jersey": Strstate.NEW_JERSEY,
  "North Carolina": Strstate.NORTH_CAROLINA,
  "Ohio": Strstate.OHIO,
  "SELECT": Strstate.SELECT,
  "South Carolina": Strstate.SOUTH_CAROLINA,
  "Washington": Strstate.WASHINGTON
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
