import 'dart:math';

import 'package:adventure_time_game/game/levels/IK/IKLevel.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../settings/enemyAnimations.dart';
import '../../settings/enemydata.dart';

enum EnemyTypeIK {
  iceWorm,
  iceKing,
  gunter,
}

class EnemyIK extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<AdventureTimeGameIK> {
  late EnemyTypeIK enemyType;
  late EnemeyData enemyData;
  static Random random = Random();
  static double yMax = 0;
  late FlameGame level;
  static double enemySpeed = 50;
  late Map<EnemyTypeIK, EnemeyData> enemyDetails;

  EnemyIK({required this.enemyType, required this.level, double? speed}) {
    if (speed != null) {
      enemySpeed = speed;
    }
    enemyDetails = {
      EnemyTypeIK.iceWorm: EnemeyData(
        sprite: iceWormSprites,
        stepTime: 0.1,
        speed: 300 + enemySpeed,
        canFly: false,
        size: Vector2(170, 69),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            35 * 2,
      ),
      EnemyTypeIK.iceKing: EnemeyData(
        sprite: iceKingSprites,
        stepTime: 0.1,
        speed: 500 + enemySpeed,
        canFly: true,
        size: Vector2.all(90),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            35 * 2,
      ),
      EnemyTypeIK.gunter: EnemeyData(
        sprite: gunterSprites,
        stepTime: 0.1,
        speed: 300 + enemySpeed,
        canFly: false,
        size: Vector2.all(60),
        y: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                .size
                .height -
            20 * 2,
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

  void checkremove(EnemyIK enemy) {
    if (enemy.x < -enemy.width) {
      gameRef.remove(this);
    }
  }
}
