import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryModel {
  String categoryName;
  String fullName;
  String recipeSteps;
  String imageUrl;
  CategoryModel({
    required this.categoryName,
    required this.imageUrl,
    required this.fullName,
    required this.recipeSteps,
  });

  static Future<List<CategoryModel>> getRandomCategories() async {
    List<CategoryModel> categories = [];

    for (int i = 0; i < 7; i++) {
      final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final meals = jsonData['meals'];

        for (var meal in meals) {
          String fullMealName = meal['strMeal'];
          String categoryName = getFirstThreeWords(fullMealName);
          String imageUrl = meal['strMealThumb'];
          String instructions = meal['strInstructions'];


          categories.add(CategoryModel(
            categoryName: categoryName,
            imageUrl: imageUrl,
            fullName: fullMealName,
            recipeSteps: instructions,
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
    }
    if(words.length == 3 ){
      if(words[2].compareTo('with')==0 || words[2].compareTo('and')==0 || words[2].compareTo('in')==0) {
        return words.sublist(0, 2).join(' ');
      }
      else {
        return words.sublist(0, 3).join(' ');
      }
    }
    else {
      return fullString;
    }
  }
}

