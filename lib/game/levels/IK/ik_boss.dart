import 'dart:math';

import 'package:adventure_time_game/game/levels/IK/IKLevel.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';

import '../../settings/enemyAnimations.dart';
// import '../../settings/enemydata.dart';

class IKBoss extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<AdventureTimeGameIK> {
  // class variables
  static Random random = Random();
  late Timer _chargeTimer, _dieTimer, _deadCheck;
  double enemySpeed = 10;
  bool isCharging = false;
  int hitsToDie = 3;
  bool isDead = false;

  IKBoss() {
    // creating the timers for the boss fight

    // timer for the charge attack
    _chargeTimer = Timer(8, repeat: true, onTick: () {
      attack1();
    });

    // timer for the dying animation
    _dieTimer = Timer(5, repeat: true, onTick: () {
      die();
    });

    // timer for the dead check
    _deadCheck = Timer(7, repeat: true, onTick: () {
      if (hitsToDie == -1) {
        isDead = true;
      }
    });
  }

  // method for the death animation
  Future<void> die() async {
    // check if the boss is dead
    if (hitsToDie == -1) {
      // stop the charge attack timer
      _chargeTimer.stop();
      isCharging = false;
      //set the animation and the size + position of the death animation
      size = Vector2(170 * 1.2, 136 * 1.2);
      y -= 15;
      animation = SpriteAnimation.spriteList(
        await Future.wait(iceBossDeathSprites),
        stepTime: 0.25,
        // loop: false,
      );
    }
  }

  @override
  Future<void>? onLoad() async {
    super.onLoad();

    // initialise the boss with the walking animation and initial position + size
    animation = SpriteAnimation.spriteList(
      await Future.wait(iceBossWalkSprites),
      stepTime: 0.1,
    );
    x = gameRef.size.x + (size.x + 1) * 60;
    y = gameRef.size.y - 35 * 2;
    anchor = Anchor.center;
    size = Vector2(170, 114);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    // cehck if the boss is not dead
    if (hitsToDie >= 0) {
      // if the boss is not charging the player and is outside the screen to the right, move the boss to the left untill it is inside the screen
      if (x > gameRef.size.x / 1.3 && !isCharging) {
        x -= enemySpeed * dt * 10;
      }

      // update the charge timer
      _chargeTimer.update(dt);

      // if the boss is charging the player and is not at the end of the screen, move the boss towards the player
      if (isCharging && x != 0) {
        x -= enemySpeed * dt * 30;
      }

      // if the boss is beyond the end of the screen, change the animation to walking animation, change its charging state to false, and move the boss back to the start of the screen
      if (x < -100) {
        animation = SpriteAnimation.spriteList(
          await Future.wait(iceBossWalkSprites),
          stepTime: 0.1,
        );
        isCharging = false;
        hitsToDie--;
      }
    } else {
      // if the boss is dead, update the die check timer
      _deadCheck.update(dt);
    }

    // if the boss is not charging, and is not at its intended position, move the boss towards its intended position
    if (x < gameRef.size.x / 1.3 && !isCharging) {
      x += enemySpeed * dt * 20;
    }

    // update the death timer regardless of the boss's state
    _dieTimer.update(dt);

    // debugPrint(hitsToDie.toString());
  }

  @override
  void onMount() {
    super.onMount();

    // add a hitbox to the boss
    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2),
      ),
    );
  }

// method for the charge attack
  void attack1() async {
    isCharging = true;
    animation = SpriteAnimation.spriteList(
      await Future.wait(iceBossChargeSprites),
      stepTime: 0.1,
    );
  }
}
