import 'package:flutter/material.dart';
import 'package:spectator/list.dart';
import 'package:spectator/snapshot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
      ),
      // home: mkListWidget(),
      home: mkSnapshotWidget(0),
    );
  }
}
