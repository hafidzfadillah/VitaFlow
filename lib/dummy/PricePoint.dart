import 'dart:math';
import 'package:collection/collection.dart';

class HeartRatePoint {
  final double x;
  final double y;

  HeartRatePoint({required this.x, required this.y});
}

List<HeartRatePoint> get heartRatePoints {
  final Random random = Random();
  final randomNumbers = <double>[];
  for (var i = 0; i <= 5; i++) {
    randomNumbers.add(random.nextDouble() * 60 + 60);
  }

  return randomNumbers
      .mapIndexed((index, element) =>
          HeartRatePoint(x: index.toDouble() * 4, y: element))
      .toList();
}
