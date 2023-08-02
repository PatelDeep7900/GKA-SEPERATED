// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  String next;
  String previous;
  int count;
  List<Result> results;

  Welcome({
    required this.next,
    required this.previous,
    required this.count,
    required this.results,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    next: json["next"],
    previous: json["previous"],
    count: json["count"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "next": next,
    "previous": previous,
    "count": count,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  String userApprov;
  Country country;
  String mob;
  BDetail bDetail;
  String address;
  String email;
  Cities cities;
  String parent;
  String address1;
  String sSanstha;
  String natCity;
  String aboutFamily;
  BLocation bLocation;
  String sParents;
  String pin;
  String phone;
  List<Familyinfo> familyinfo;
  String name;
  BWebsite bWebsite;
  String id;
  State1 state;
  String ext2;
  Ext1 ext1;

  Result({
    required this.userApprov,
    required this.country,
    required this.mob,
    required this.bDetail,
    required this.address,
    required this.email,
    required this.cities,
    required this.parent,
    required this.address1,
    required this.sSanstha,
    required this.natCity,
    required this.aboutFamily,
    required this.bLocation,
    required this.sParents,
    required this.pin,
    required this.phone,
    required this.familyinfo,
    required this.name,
    required this.bWebsite,
    required this.id,
    required this.state,
    required this.ext2,
    required this.ext1,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    userApprov: json["User_Approv"],
    country: countryValues.map[json["country"]]!,
    mob: json["Mob"],
    bDetail: bDetailValues.map[json["B_Detail"]]!,
    address: json["address"],
    email: json["Email"],
    cities: citiesValues.map[json["cities"]]!,
    parent: json["Parent"],
    address1: json["address1"],
    sSanstha: json["s_sanstha"],
    natCity: json["Nat_City"],
    aboutFamily: json["About_Family"],
    bLocation: bLocationValues.map[json["B_location"]]!,
    sParents: json["S_Parents"],
    pin: json["pin"],
    phone: json["Phone"],
    familyinfo: List<Familyinfo>.from(json["familyinfo"].map((x) => Familyinfo.fromJson(x))),
    name: json["name"],
    bWebsite: bWebsiteValues.map[json["B_Website"]]!,
    id: json["id"],
    state: stateValues.map[json["state"]]!,
    ext2: json["ext2"],
    ext1: ext1Values.map[json["ext1"]]!,
  );

  Map<String, dynamic> toJson() => {
    "User_Approv": userApprov,
    "country": countryValues.reverse[country],
    "Mob": mob,
    "B_Detail": bDetailValues.reverse[bDetail],
    "address": address,
    "Email": email,
    "cities": citiesValues.reverse[cities],
    "Parent": parent,
    "address1": address1,
    "s_sanstha": sSanstha,
    "Nat_City": natCity,
    "About_Family": aboutFamily,
    "B_location": bLocationValues.reverse[bLocation],
    "S_Parents": sParents,
    "pin": pin,
    "Phone": phone,
    "familyinfo": List<dynamic>.from(familyinfo.map((x) => x.toJson())),
    "name": name,
    "B_Website": bWebsiteValues.reverse[bWebsite],
    "id": id,
    "state": stateValues.reverse[state],
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

enum Cities {
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

final citiesValues = EnumValues({
  "Beach": Cities.BEACH,
  "Brewton": Cities.BREWTON,
  "Columbus": Cities.COLUMBUS,
  "Cumming": Cities.CUMMING,
  "Edison": Cities.EDISON,
  "Kenner": Cities.KENNER,
  "Little Rock": Cities.LITTLE_ROCK,
  "Lynnwood": Cities.LYNNWOOD,
  "Newnan": Cities.NEWNAN,
  "New Bern": Cities.NEW_BERN,
  "SELECT": Cities.SELECT,
  "West Columbia": Cities.WEST_COLUMBIA
});

enum Country {
  CANADA,
  UNITED_STATES
}

final countryValues = EnumValues({
  "Canada": Country.CANADA,
  "United States": Country.UNITED_STATES
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

enum State1 {
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

final stateValues = EnumValues({
  "Alabama": State1.ALABAMA,
  "Arkansas": State1.ARKANSAS,
  "Florida": State1.FLORIDA,
  "Georgia": State1.GEORGIA,
  "Louisiana": State1.LOUISIANA,
  "New Jersey": State1.NEW_JERSEY,
  "North Carolina": State1.NORTH_CAROLINA,
  "Ohio": State1.OHIO,
  "SELECT": State1.SELECT,
  "South Carolina": State1.SOUTH_CAROLINA,
  "Washington": State1.WASHINGTON
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