
import 'package:flutter/material.dart';
import 'package:flutterssignment/NewTask.dart';
import 'package:flutterssignment/listMain.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) => listMain(),
        '/NewTask': (context) => NewTask(),
      },
    )
  );
}
