
class CountryModel {

  final String sortname;
  final int id;
  final String name;
  final String phonecode;

  CountryModel({
    required this.sortname,
    required this.id,
    required this.name,
    required this.phonecode,
  });



  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      sortname: json["sortname"],
      id: json["id"],
      name: json["name"],
      phonecode: json["phonecode"],
    );
  }

  static List<CountryModel> fromJsonList(List list) {
    return list.map((item) => CountryModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#${this.id.toString()} ${this.name}';
  }

  bool userFilterByCreationDate(String filter) {
    return this.id.toString().contains(filter);
  }

  bool isEqual(CountryModel model) {
    return this.id.toString() == model.id.toString();
  }

  @override
  String toString() => name;
}