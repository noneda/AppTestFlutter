class Datasapi {
  int id;
  String name;
  // ignore: non_constant_identifier_names
  int TpUser;

  // ignore: non_constant_identifier_names
  Datasapi({required this.id, required this.name, required this.TpUser});

  factory Datasapi.fromJson(Map<String, dynamic> json) {
    return Datasapi(id: json['id'], name: json['name'], TpUser: json['TpUser']);
  }
}
