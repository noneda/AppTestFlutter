// ignore_for_file: non_constant_identifier_names

class Utilapi {
  int id;
  String name;
  int TpUser;

  Utilapi({required this.id, required this.name, required this.TpUser});

  factory Utilapi.fromJson(Map<String, dynamic> json) {
    return Utilapi(id: json['id'], name: json['name'], TpUser: json['TpUser']);
  }
}
