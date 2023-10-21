class Csc {
  String? sortname;
  String? name;
  String? phonecode;
  int? id;

  Csc({this.sortname, this.name, this.phonecode, this.id});

  Csc.fromJson(Map<String, dynamic> json) {
    sortname = json['sortname'];
    name = json['name'];
    phonecode = json['phonecode'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sortname'] = this.sortname;
    data['name'] = this.name;
    data['phonecode'] = this.phonecode;
    data['id'] = this.id;
    return data;
  }
}