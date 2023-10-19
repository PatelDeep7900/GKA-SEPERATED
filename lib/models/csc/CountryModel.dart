
class CountryModel {
  String? sortname;
  int? id;
  String? name;
  String? phonecode;

  CountryModel({required this.sortname, required this.id, required this.name, required this.phonecode});

  CountryModel.fromJson(Map<String, dynamic> json) {
    sortname = json['sortname'];
    id = json['id'];
    name = json['name'];
    phonecode = json['phonecode'];
  }

  static List<CountryModel> fromJsonList(List list) {
    return list.map((item) => CountryModel.fromJson(item)).toList();
  }

  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  bool userFilterByCreationDate(String filter) {
    return this.id.toString().contains(filter);
  }

  bool isEqual(CountryModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => name.toString();
}