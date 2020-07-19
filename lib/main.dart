import 'package:flutter/material.dart';
//import 'package:category_widget_x/category.dart';
import 'package:category_widget_x/category_route.dart';

const _categoryName = 'Cake';
const _categoryIcon = Icons.cake;
const _categoryColor = Colors.green;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Unit Converter',
      home: CategoryRoute(),
      /*home:  Scaffold(
        backgroundColor: Colors.green[100],
        body: Center(
          child: Category(
            name: _categoryName,
            color: _categoryColor,
            iconLocation: _categoryIcon,
          ),
        ),
      ),*/
    );
  }
}
