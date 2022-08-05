import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import'../widgets/main_drawer.dart';
import'../models/meal.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() => TabsScreenState();
  List<Meal> favoriteMeals;
  TabsScreen(this.favoriteMeals);
}

class TabsScreenState extends State<TabsScreen> {
   List<Map<String, dynamic>>? pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
   pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Meals Categories',
    },
    {
      'page': FavoritesScreen(widget.favoriteMeals),
      'title': 'Favorites',
    }
  ];
    super.initState();
  }


  void selectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages![selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: pages![selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        // backgroundColor: Color.fromARGB(255, 2, 20, 157),
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 2, 20, 157),
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 2, 20, 157),
            icon: Icon(
              Icons.star,
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
