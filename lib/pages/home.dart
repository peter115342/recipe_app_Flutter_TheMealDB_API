import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/models/categoryModel.dart';
import 'package:food_app/pages/recipe.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  late Timer timer;
  bool isDarkMode = false;


  @override
  void initState() {
    super.initState();
    getCategories(); // Call initially
    timer = Timer.periodic(const Duration(minutes: 10), (Timer t) => getCategories());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getCategories() async {
    categories = await CategoryModel.getRandomCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSearch(),
          const SizedBox(height: 10),
          Expanded(
            child: buildListView(),

          ),
        ],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
            itemCount: categories.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipePage(
                        fullName: categories[index].fullName,
                        categoryName: categories[index].categoryName,
                        imageUrl: categories[index].imageUrl,
                        recipeSteps: categories[index].recipeSteps,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(20),
                  height: 428,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(categories[index].imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 310),
                          child: Text(
                            categories[index].categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }

  Container buildSearch() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          border: InputBorder.none,
          hintText: 'Search Omelette',
          prefixIcon: const Icon(Icons.search, color: Colors.black, size: 35),

        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Meal App',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            isDarkMode = !isDarkMode; // Toggle the dark mode
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode, // Change icon based on mode
              color: Colors.black,
              size: 35,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // TODO: Implement action
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Center(
              child: Icon(Icons.more_horiz, color: Colors.black, size: 35),
            ),
          ),
        ),
      ],
    );
  }
}
