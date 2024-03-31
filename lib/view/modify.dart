// ignore_for_file: unused_import, unused_field, use_build_context_synchronously

import 'package:app/model/api.dart';
import 'package:app/model/apilist.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:app/services/services.dart';

class Modify extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final int id;
  const Modify({super.key, required this.id});

  @override
  State<Modify> createState() => _ModifyState();
}

class _ModifyState extends State<Modify> {
  // ignore: unnecessary_null_comparison
  bool get _isEditing => widget.id != 0;
  Apiservice get serv => GetIt.I<Apiservice>();
  late String errorMessage;
  late Utilapi api;
  late String send;
  late String title;

  final TextEditingController _namectl = TextEditingController();
  final TextEditingController _contctl = TextEditingController();
  late bool _isLoading = true;

  @override
  void initState() {
    setState(() {
      _isLoading = false;
    });
    if (_isEditing) {
      serv.getapi(widget.id.toString()).then((res) async {
        if (res.error) {
          errorMessage = res.errorMessage;
        }
        api = res.data;
        _namectl.text = api.name;
        _contctl.text = api.TpUser.toString();
      });
    } else {
      _namectl.text = 'name';
      _contctl.text = '0';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              _isEditing ? 'Edit User with id ${widget.id}' : 'Create User')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  TextField(
                    controller: _namectl,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  Container(height: 8),
                  TextField(
                    controller: _contctl,
                    decoration: const InputDecoration(hintText: 'TpUser'),
                  ),
                  Container(height: 16),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            if (!_isEditing) {
                              title = "Sendly";
                              if (!serv.postNew(_namectl.text, _contctl.text)) {
                                send = "User Createl";
                              } else {
                                send = "Error";
                              }
                            } else {
                              title = "Edit";
                              if (!serv.putUpdate(_namectl.text, _contctl.text,
                                  widget.id.toString())) {
                                send = "Usuario Actualizado";
                              } else {
                                send = "Error";
                              }
                            }
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(send),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok'))
                                      ],
                                    ));
                          },
                          child: const Text('Submit')))
                ],
              ),
      ),
    );
  }
}
