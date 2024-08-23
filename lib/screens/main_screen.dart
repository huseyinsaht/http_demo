import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_demo/data/api/category_api.dart';
import '../models/category.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  var categories = List<Category>.empty(growable: true);
  var categoryWidgets = List<Widget>.empty(growable: true);

  @override
  void initState() {
    getCategoriesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shopping System",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryWidgets,
                ),
              )
            ],
          ),
        ));
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((category) => {
          setState(() {
            var list = json.decode(category.body);
            categories =
                list.map((category) => Category.fromJson(category)).toList();
          })
        });
  }
}
