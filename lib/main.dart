import 'package:flutter/material.dart';
import 'package:template/info_view.dart';
import 'package:template/past_votes_view.dart';
import 'votering_api.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'mystate.dart';

void main() {
  MyState state = MyState();

  runApp(
    ChangeNotifierProvider(create: (context) => state, child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: InfoView(),
    );
  }
}
