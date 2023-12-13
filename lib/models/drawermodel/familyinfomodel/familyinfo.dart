class familyinfo {
  String? phone;
  String? dob;
  String? name;
  String? occ;
  String? email;
  String? relation;
  int? Auto_no;

  familyinfo(
      {this.phone, this.dob, this.name, this.occ, this.email, this.relation,this.Auto_no});

  familyinfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    dob = json['dob'];
    name = json['name'];
    occ = json['occ'];
    email = json['email'];
    relation = json['relation'];
    Auto_no = json['Auto_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['name'] = this.name;
    data['occ'] = this.occ;
    data['email'] = this.email;
    data['relation'] = this.relation;
    data['Auto_no'] = this.Auto_no;

    return data;
  }
  static List<familyinfo> fromJsonList(List list) {
    return list.map((item) => familyinfo.fromJson(item)).toList();
  }
}