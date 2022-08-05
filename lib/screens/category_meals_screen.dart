import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeal;
  var loadedInitData = false;
  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (!loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();

      loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void removeMeal(String mealId) {
    setState(
      () {
        displayedMeal!.removeWhere((meal) => meal.id == mealId);
      },
    );
  }

  // final String categoryId;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: displayedMeal![index].id,
              title: displayedMeal![index].title,
              imageUrl: displayedMeal![index].imageUrl,
              duration: displayedMeal![index].duration,
              complexity: displayedMeal![index].complexity,
              affordability: displayedMeal![index].affordability!,
             // removeItem: removeMeal
             );
        },
        itemCount: displayedMeal!.length,
      ),
    );
  }
}
