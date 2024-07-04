import 'dart:io';

import 'package:first_project/src/pages/coffee_shop_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофейня',
      home: CoffeeShopPage(),
    );
  }
}