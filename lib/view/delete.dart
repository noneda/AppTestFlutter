import 'package:flutter/material.dart';
import 'package:app/services/services.dart';
import 'package:get_it/get_it.dart';

class DelData extends StatefulWidget {
  final int id;
  const DelData({super.key, required this.id});

  @override
  State<DelData> createState() => _DelData();
}

class _DelData extends State<DelData> {
  Apiservice get serv => GetIt.I<Apiservice>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Warnning'),
      content: const Text('Are you sure you want to delete this User?'),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('Yes'),
            onPressed: () => {
                  if (!serv.delDelete(widget.id.toString()))
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text("Delete"),
                              content: const Text("Data Eliminated"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Ok'))
                              ],
                            ))
                }),
        ElevatedButton(
            child: const Text('No'),
            onPressed: () => {Navigator.of(context).pop(false)})
      ],
    );
  }
}
