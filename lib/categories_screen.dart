import 'package:flutter/material.dart';
import './categoryItem.dart';
import './dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Delimeals'),
        ),
        body: GridView(
          padding: const EdgeInsets.all(25),
          children: <Widget>[
            ...DUMMY_CATEGORIES
                .map((e) => CategoryItem(e.id, e.title, e.color))
                .toList()
          ],
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
        ));
  }
}
