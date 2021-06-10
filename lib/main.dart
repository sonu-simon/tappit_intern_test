import 'package:flutter/material.dart';
import 'package:tappit_intern_test/cart_page_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CartUI(),
    );
  }
}
