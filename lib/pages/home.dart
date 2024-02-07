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
        const Duration(minutes: 5), (Timer t) => getRandomCategories());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(

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
      ),
    );
  }

  ListView buildListView() {
    List<CategoryModel> displayedCategories =
    isSearchActive ? categories : categories;

    return ListView(
      children: [
        if (!isSearchActive)
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
        else
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
                      color: Colors.black.withOpacity(0.5),
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
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15)),
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
        color: isDarkMode ? Colors.black : Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
        boxShadow:  [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 5),
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
          fillColor: isDarkMode ? Colors.black54 : Colors.grey[200],
          border: InputBorder.none,
          hintText: 'Search Omelette',
          prefixIcon:  Icon(Icons.search, color: isDarkMode ? Colors.white : Colors.black, size: 35),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'CuisineQuest',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}

final lightTheme = ThemeData(
  primaryColor: Colors.white,
  colorScheme: const ColorScheme.light(),
);

final darkTheme = ThemeData(
  primaryColor: Colors.black,
  colorScheme: const ColorScheme.dark(),

);
