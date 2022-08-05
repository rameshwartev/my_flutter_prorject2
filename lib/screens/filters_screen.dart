import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/fliters';

  final Function saveFilters;
  final Map currentFilters;
  FiltersScreen(this.saveFilters, this.currentFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var glutenFree = false;
  var vegan = false;
  var vegetarian = false;
  var lactoseFree = false;

  initState() {
    glutenFree = widget.currentFilters['gluten'];
    lactoseFree = widget.currentFilters['lactose'];
    vegan = widget.currentFilters['vegan'];
    vegetarian = widget.currentFilters['vegetarian'];
    super.initState();
  }

  Widget buildSwitchListTile(
    String title,
    //String subTitle,
    bool currentValue,
    void Function(bool) NewValue,
  ) {
    return SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'KaushanScript',
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        // subtitle: Text(
        //   subTitle,
        //   style: TextStyle(
        //     fontFamily: 'KaushanScript',
        //     fontSize: 18,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        value: currentValue,
        onChanged: NewValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Filters',
          style: TextStyle(
            fontFamily: 'Tangerine',
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': glutenFree,
                'lactose': lactoseFree,
                'vegetarian': vegetarian,
                'vegan': vegan,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust Your Meal Selection',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  'Gluten-Free',
                  // 'Only Includes Gluten Free Meals',
                  glutenFree,
                  (NewValue) {
                    setState(
                      () {
                        glutenFree = NewValue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  'Lactose-Free',
                  // 'Only Includes Lactose Free Meals',
                  lactoseFree,
                  (NewValue) {
                    setState(
                      () {
                        lactoseFree = NewValue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  //  'Only Includes Vegetarian Meals',
                  vegetarian,
                  (NewValue) {
                    setState(
                      () {
                        vegetarian = NewValue;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  //  'Only Includes Vegan Meals',
                  vegan,
                  (NewValue) {
                    setState(
                      () {
                        vegan = NewValue;
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
