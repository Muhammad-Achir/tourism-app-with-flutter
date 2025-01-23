import 'package:flutter/material.dart';

enum TourismColors {
  blue('Blue', Colors.blue),
  red('red', Colors.red);

  const TourismColors(this.name, this.color);
  final String name;
  final Color color;
}
