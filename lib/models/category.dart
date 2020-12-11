import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  // We should add const infront of class construtor because the categories must be immutable in data and we have defined a list with const keyword in the data.
  const Category(
      {@required this.id, @required this.title, this.color = Colors.orange});
}
