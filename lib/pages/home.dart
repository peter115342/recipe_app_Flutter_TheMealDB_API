import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_app/models/category_model.dart';
import 'package:food_app/pages/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  late Timer timer;
  bool isDarkMode = false;
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    getRandomCategories();
    timer = Timer.periodic(
        const Duration(minutes: 10), (Timer t) => getRandomCategories());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void getRandomCategories() async {
    if (!isSearchActive) {
      categories = await CategoryModel.getRandomCategories();
      setState(() {});
    }
  }

  void getCategories(String input) async {
    if (input.isNotEmpty) {
      categories = await CategoryModel.getCategories(input);
      setState(() {});
    } else {
      getRandomCategories();
    }
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
    List<CategoryModel> displayedCategories = isSearchActive ? categories : categories;

    return ListView(
      children: [
        if (!isSearchActive) // Display different text when search is not active
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Random recipes for you!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        else // Display "Our Picks" text when search is active
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Results : ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: displayedCategories.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(
                      fullName: displayedCategories[index].fullName,
                      categoryName: displayedCategories[index].categoryName,
                      imageUrl: displayedCategories[index].imageUrl,
                      recipeSteps: displayedCategories[index].recipeSteps,
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
                    image: NetworkImage(displayedCategories[index].imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 310),
                        child: Text(
                          displayedCategories[index].categoryName,
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
        ),
      ],
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
        controller: searchController,
        onChanged: (value) {
          setState(() {
            isSearchActive = value.isNotEmpty;
          });
          getCategories(value);
        },
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
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode, // TODO: Dark mode and light mode switching
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
