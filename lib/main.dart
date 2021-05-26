import 'package:flutter/material.dart';
import 'screens/general_purpose/home_screen.dart';
import 'screens/editor/test_editor.dart';

void main() => runApp(MaterialApp(

  routes: {
    "/": (context) => MyHomePage(),
    '/editor_test': (context) => TestEditor(),
    // "/": (context) => (),
    // "/": (context) => (),
    // "/": (context) => (),
    // "/": (context) => (),
    // "/": (context) => (),

  },
)
);



