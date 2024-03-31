// ignore_for_file: unused_import, camel_case_types, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print
import 'dart:convert';

import 'package:app/model/apilist.dart';
import 'package:app/model/api.dart';
import 'package:app/model/clslist.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  static const ip = '192.168.100.223';
  // ignore: constant_identifier_names
  //static const api = 'https://jsonplaceholder.typicode.com/albums/';
  static const app = 'http://' + ip + ':5050/api';

  static const headers = {'Content-Type': 'application/json'};

  Future<Apires<List<Datasapi>>> getApi() {
    return http.get(Uri.parse(app)).then((data) {
      final err = <Datasapi>[];
      err.add(Datasapi(id: 0, name: "Error", TpUser: 2));
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final datas = <Datasapi>[];
        for (var item in jsonData) {
          datas.add(Datasapi.fromJson(item));
        }
        return Apires<List<Datasapi>>(data: datas, errorMessage: "none");
      }
      return Apires<List<Datasapi>>(
          data: err, errorMessage: "Error", error: true);
    });
  }

  Future<Apires<Utilapi>> getapi(String i) {
    return http.get(Uri.parse(app + '/' + i)).then((data) {
      final err = Utilapi(id: 0, name: 'Error', TpUser: 2);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return Apires<Utilapi>(
            data: Utilapi.fromJson(jsonData), errorMessage: "none");
      }
      return Apires<Utilapi>(data: err, errorMessage: "Error", error: true);
    });
  }

  bool postNew(String a, String b) {
    String send = app + '?a=' + a + '&b=' + b;
    http.post(Uri.parse(send), headers: headers).then((value) {
      if (value.statusCode == 201) {
        return true;
      }
    });
    return false;
  }

  bool putUpdate(String a, String b, String c) {
    String send = app + '?a=' + a + '&b=' + b + '&id= ' + c;
    http.put(Uri.parse(send), headers: headers).then((value) {
      if (value.statusCode == 201) {
        return true;
      }
    });
    return false;
  }

  bool delDelete(String a) {
    String send = app + '?a=' + a;
    http.delete(Uri.parse(send), headers: headers).then((value) {
      if (value.statusCode == 201) {
        return true;
      }
    });
    return false;
  }
/*
  List<Datasapi> getapilist() {
    return [
      Datasapi(id: 1, name: "Admin", TpUser: 1),
      Datasapi(id: 2, name: "JuanDa", TpUser: 0),
      Datasapi(id: 3, name: "User", TpUser: 0),
    ];
  }

  Future<Datasapi> fetchApi() async {
    final response =
        await http.get(Uri.parse('http://192.168.100.223:5050/api/1'));
    if (response.statusCode == 200) {
      return Datasapi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to lod Api');
    }
  }
*/
}
