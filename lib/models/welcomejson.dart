
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
  String address;
  String name;
  String id;

  Result({
    required this.address,
    required this.name,
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    address: json["address"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "name": name,
    "id": id,
  };
}
