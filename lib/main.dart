

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:war_game_map_tool/screens/home_page.dart';
import 'package:war_game_map_tool/screens/table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:_main(title: 'Map Tool'),
    );
  }
}

class _main extends StatefulWidget {
  const _main({super.key, required String title});

  @override
  State<_main> createState() => _mainState();
}

class _mainState extends State<_main> {
  @override
  Widget build(BuildContext context) {
    return homepage();
  }
}

