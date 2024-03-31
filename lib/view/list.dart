import 'package:app/model/apilist.dart';
import 'package:app/model/clslist.dart';
import 'package:flutter/material.dart';
import 'package:app/view/modify.dart';
import 'package:app/view/delete.dart';
import 'package:app/services/services.dart';
import 'package:get_it/get_it.dart';

// ignore: camel_case_types, must_be_immutable
class list extends StatefulWidget {
  const list({super.key});

  @override
  State<list> createState() => _listState();
}

// ignore: camel_case_types
class _listState extends State<list> {
  Apiservice get service => GetIt.I<Apiservice>();
  bool _isLoading = false;
  late Apires<List<Datasapi>> _apires;

  @override
  void initState() {
    _fetchDatas();
    super.initState();
  }

  _fetchDatas() async {
    setState(() {
      _isLoading = true;
    });
    _apires = await service.getApi();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List of Users'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.of(context)
                // ignore: prefer_const_constructors
                .push(MaterialPageRoute(builder: (_) {
              return const Modify(id: 0);
            }))
          },
          child: const Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return const CircularProgressIndicator();
            }
            if (_apires.error) {
              return Center(
                child: Text(_apires.errorMessage),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, color: Colors.grey),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apires.data[index].id),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final res = await showDialog(
                        context: context,
                        builder: (_) => DelData(id: _apires.data[index].id));
                    return res;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apires.data[index].name,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        'Id is : ${_apires.data[index].id} and  Type User is ${_apires.data[index].TpUser}'),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Modify(
                                id: _apires.data[index].id,
                              )))
                    },
                  ),
                );
              },
              itemCount: _apires.data.length,
            );
          },
        ));
  }
}
