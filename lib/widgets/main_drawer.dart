import 'package:flutter/material.dart';

import'../screens/filters_screen.dart';
class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon, String title,VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 38,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'KaushanScript',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          //color:Theme.of(context).accentColor,
        ),
      ),
      onTap: tapHandler 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Color.fromARGB(255, 2, 20, 157),
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontFamily: 'Tangerine',
                fontSize: 70,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          //SizedBox(height: 20),

          SizedBox(height: 20),
          Container(
            color: Colors.black12,
            child: buildListTile(
              Icons.restaurant_menu,
              'Meals',
              (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          Container(
            color: Colors.black12,
            child: buildListTile(
              Icons.settings,
              'Settings',
            (){
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            },
            ),
          ),
        ],
      ),
    );
  }
}
