import 'package:app/services/services.dart';
import 'package:flutter/material.dart';
import 'package:app/view/list.dart';
import 'package:get_it/get_it.dart';

void setupLocator() => GetIt.instance.registerLazySingleton(() => Apiservice());

void main() {
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const list(),
    );
  }
}
