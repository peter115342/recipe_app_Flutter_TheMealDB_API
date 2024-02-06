import 'package:flutter/material.dart';

class CategoryModel {
  String categoryName;
  String imageUrl;
  Color color;

  CategoryModel({required this.categoryName, required this.imageUrl, required this.color});

 static List<CategoryModel> getCategories(){
List<CategoryModel> categories = [
      CategoryModel(categoryName: 'Burger', imageUrl: 'assets/images/burger.png', color: Colors.red),
      CategoryModel(categoryName: 'Pizza', imageUrl: 'assets/images/pizza.png', color: Colors.green),
      CategoryModel(categoryName: 'Beer', imageUrl: 'assets/images/beer.png', color: Colors.blue),
      CategoryModel(categoryName: 'Coffee', imageUrl: 'assets/images/coffee.png', color: Colors.orange),
      CategoryModel(categoryName: 'Cupcake', imageUrl: 'assets/images/cupcake.png', color: Colors.purple),
    ];
    return categories;

  }
}