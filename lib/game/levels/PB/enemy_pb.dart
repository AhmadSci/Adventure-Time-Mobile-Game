import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../settings/enemyAnimations.dart';
import '../../settings/enemydata.dart';

// defining the types of enemies in this level
enum EnemyTypePB {
  cinamonBun,
  bananaGuard,
  PB,
}

class EnemyPB extends SpriteAnimationComponent with CollisionCallbacks {
  // class variables
  late EnemyTypePB enemyType;
  late EnemeyData enemyData;
  static Random random = Random();
  static double yMax = 0;
  late FlameGame level;
  static double enemySpeed = 50;

  late Map<EnemyTypePB, EnemeyData> enemyDetails;

  EnemyPB({required this.enemyType, required this.level, double? speed}) {
    // setting the speed of the enemy if it is given in the constructor
    if (speed != null) {
      enemySpeed = speed;
    }

    // setting the enemy details for each enemy type listed in the enum
    enemyDetails = {
      EnemyTypePB.cinamonBun: EnemeyData(
        sprite: cinamonSprites,
        stepTime: 0.1,
        speed: 300 + enemySpeed,
        canFly: false,
        size: Vector2.all(100),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            35 * 2,
      ),
      EnemyTypePB.bananaGuard: EnemeyData(
        sprite: bananaSprites,
        stepTime: 0.1,
        speed: 300 + enemySpeed,
        canFly: false,
        size: Vector2.all(90),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            30 * 2,
      ),
      EnemyTypePB.PB: EnemeyData(
        sprite: pbSprites,
        stepTime: 0.1,
        speed: 600 + enemySpeed,
        canFly: true,
        size: Vector2.all(140),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            35 * 2,
      ),
    };
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    // setting the data for each enemy on load of the enemy
    enemyData = enemyDetails[enemyType] as EnemeyData;
    animation = SpriteAnimation.spriteList(
      await Future.wait(enemyData.sprite),
      stepTime: enemyData.stepTime,
    );
    x = level.size.x + (size.x + 1) * 60;
    y = enemyData.y;
    anchor = Anchor.center;
    size = enemyData.size;

    // setting the max y value for the enemies that can fly
    if (enemyData.canFly && random.nextBool()) {
      y -= height * (1 + random.nextDouble());
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // changing the x position of the enemy per frame based on the speed
    x -= enemyData.speed * dt;

    // checking if the enemy is off screen and if so removing it
    checkremove(this);
  }

  @override
  void onMount() {
    super.onMount();

    // adding a hitbox to the enemy
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2),
      ),
    );
  }

//a function to check if the enemy is off screen and if so removing it
  void checkremove(EnemyPB enemy) {
    if (enemy.x < -enemy.width) {
      level.remove(this);
    }
  }
}
