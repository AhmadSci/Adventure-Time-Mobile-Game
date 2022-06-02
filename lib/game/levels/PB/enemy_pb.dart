import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../settings/enemyAnimations.dart';
import '../../settings/enemydata.dart';

enum EnemyTypePB {
  cinamonBun,
  bananaGuard,
  PB,
}

class EnemyPB extends SpriteAnimationComponent with CollisionCallbacks {
  late EnemyTypePB enemyType;
  late EnemeyData enemyData;
  static Random random = Random();
  static double yMax = 0;
  late FlameGame level;
  static double enemySpeed = 50;

  late Map<EnemyTypePB, EnemeyData> enemyDetails;

  EnemyPB({required this.enemyType, required this.level, double? speed}) {
    if (speed != null) {
      enemySpeed = speed;
    }
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
    enemyData = enemyDetails[enemyType] as EnemeyData;
    animation = SpriteAnimation.spriteList(
      await Future.wait(enemyData.sprite),
      stepTime: enemyData.stepTime,
    );
    x = level.size.x + (size.x + 1) * 60;
    y = enemyData.y;
    anchor = Anchor.center;
    size = enemyData.size;
    if (enemyData.canFly && random.nextBool()) {
      y -= height * (1 + random.nextDouble());
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= enemyData.speed * dt;

    checkremove(this);
  }

  @override
  void onMount() {
    super.onMount();
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2),
      ),
    );
  }

  void checkremove(EnemyPB enemy) {
    if (enemy.x < -enemy.width) {
      level.remove(this);
    }
  }
}
