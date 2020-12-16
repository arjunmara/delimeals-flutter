import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import 'screens/filter_screen.dart';
import 'screens/tab_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavs(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);

    existingIndex >= 0
        ? setState(() {
            _favoriteMeals.removeAt(existingIndex);
          })
        : setState(() {
            _favoriteMeals
                .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
          });
  }

  bool _isMealFav(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'A meals app',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavs, _isMealFav),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      // we can access some of the arguements and apply some logic with the help of them.
      //   return MaterialPageRoute(builder: (ctx) {
      //     return CategoriesScreen();
      //   });
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
