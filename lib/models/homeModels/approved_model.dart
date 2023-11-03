class approved {
  List<Data>? data;
  bool? datafound;

  approved({this.data, this.datafound});

  approved.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    datafound = json['datafound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['datafound'] = this.datafound;
    return data;
  }
}

class Data {
  String? email;
  String? autoNo;
  String? id;
  String? name;

  Data({this.email, this.autoNo, this.id, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    autoNo = json['auto_no'];
    id = json['id'];
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['auto_no'] = this.autoNo;
    data['id'] = this.id;
    data['Name'] = this.name;
    return data;
  }
}