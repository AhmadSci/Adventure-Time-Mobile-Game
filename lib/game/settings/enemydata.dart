import 'package:flame/components.dart';

/* 
*******************************************************************************

        this class is for storing the data for each individual enemy

*******************************************************************************
*/

class EnemeyData {
  late Iterable<Future<Sprite>> sprite;
  late double stepTime;
  late double speed;
  late bool canFly;
  late Vector2 size;
  late double y;

  EnemeyData(
      {required this.sprite,
      required this.stepTime,
      required this.speed,
      required this.canFly,
      required this.size,
      required this.y});
}
