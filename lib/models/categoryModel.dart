import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryModel {
  String categoryName;
  String imageUrl;
  Color color;

  CategoryModel({
    required this.categoryName,
    required this.imageUrl,
    required this.color,
  });

  static Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];

    for (int i = 0; i < 5; i++) { // Adjust the number of random meals you want to fetch
      final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final meals = jsonData['meals'];

        for (var meal in meals) {
          String fullMealName = meal['strMeal'];
          String categoryName = getFirstThreeWords(fullMealName);
          String imageUrl = meal['strMealThumb'];
          Color color = Colors.red;

          categories.add(CategoryModel(
            categoryName: categoryName,
            imageUrl: imageUrl,
            color: color,
          ));

          print('Meal: $categoryName');
        }
      } else {
        throw Exception('Failed to load categories');
      }
    }

    return categories;
  }

  static String getFirstThreeWords(String fullString) {
    List<String> words = fullString.split(' ');
    if (words.length > 3) {
      return words.sublist(0, 3).join(' ');
    } else {
      return fullString;
    }
  }
}

