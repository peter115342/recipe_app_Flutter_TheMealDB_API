import 'package:flutter/material.dart';
import 'package:food_app/models/categoryModel.dart';
class HomePage extends StatelessWidget {
   HomePage({Key? key});

List<CategoryModel> categories = CategoryModel.getCategories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Column(
          children: [
            buildSearch(),
            SizedBox.fromSize(size: const Size.fromHeight(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox.fromSize(size: const Size.fromHeight(20)),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 150,
                        decoration: BoxDecoration(
                          color: categories[index].color,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            categories[index].categoryName,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),

                ),
              ],
            )
          ],
        ));
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
          suffixIcon: const SizedBox(
            width: 90,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 0.4,
                    width: 20,
                  ),
                  Icon(Icons.filter_list, color: Colors.black, size: 35),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Meal App',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // TODO
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(Icons.chevron_left_outlined,
                color: Colors.black, size: 35),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            // TODO
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
