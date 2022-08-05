import 'package:flutter/material.dart';

import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];

  void setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (filters['gluten']! && !meal.isGlutenFree) {
            return false;
          }
          if (filters['lactose']! && !meal.isLactoseFree) {
            return false;
          }
          if (filters['vegan']! && !meal.isVegan) {
            return false;
          }
          if (filters['vegetarian']! && !meal.isVegetarian) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void toggleFavorite(String mealId) {
    final existingIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(
      () {
        if (existingIndex >= 0) {
          favoriteMeals.removeAt(existingIndex);
        } else {
          setState(
            () {
              favoriteMeals.add(
                DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
              );
            },
          );
        }
      },
    );
  }

  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Recipe Book',
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(230, 230, 255, 1),
        colorScheme: ColorScheme.highContrastLight(),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline6: TextStyle(
                fontSize: 40,
                fontFamily: 'Tangerine',
                fontWeight: FontWeight.w900,
              ),
            ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              toggleFavorite,
              isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFilters,
              filters,
            ),
      },
      //onGenerateRoute: (){}

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
