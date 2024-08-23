import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_demo/data/api/category_api.dart';
import 'package:http_demo/data/api/product_api.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../widgets/product_list_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  var categories = List<Category>.empty(growable: true);
  var categoryWidgets = List<Widget>.empty(growable: true);
  var products = List<Product>.empty(growable: true);
  @override
  void initState() {
    getCategoriesFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Shopping System",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categoryWidgets,
                ),
              ),
              ProductListWidget(products),
            ],
          ),
        )
    );
  }

  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((response) => {
          setState(() {
            Iterable list = json.decode(response.body);
            categories =
                list.map((category) => Category.fromJson(category)).toList();
            getCategoryWidgets();
          })
        });
  }

  getCategoryWidgets() {
    for (var t in categories) {
      categoryWidgets.add(getCategoryWidget(t));
    }
  }

  Widget getCategoryWidget(Category category) {
    return TextButton(
      onPressed: () {
        getProductsByCategoryId(category);
      },
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: const BorderSide(color: Colors.deepPurpleAccent),
          ),
        ),
      ),
      child: Text(
        category.categoryName!,
        style: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }

  void getProductsByCategoryId(Category category) {
    ProductApi.getProductsByCategoryId(category.id!).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        products = list.map((product) => Product.fromJson(product)).toList();
      });
    });
  }
}
