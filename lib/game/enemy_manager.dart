// ignore_for_file: avoid_init_to_null

import 'dart:math';

import 'package:adventure_time_game/game/levels/PB/enemy_pb.dart';
import 'package:adventure_time_game/game/levels/IK/IKLevel.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
// import 'package:flutter/material.dart';

import 'levels/IK/enemy_ik.dart';
import 'levels/PB/PBLevel.dart';

class EnemyManager extends Component {
  late Random random;
  late Timer timer;
  late int amuntOfEnemies;
  late int spawnLevel;
  late double time, timeLimit;
  late FlameGame levelref;
  AdventureTimeGamePB? pBlevel = null;
  AdventureTimeGameIK? iKlevel = null;
  double speed = 100;

  EnemyManager(this.amuntOfEnemies, this.levelref) {
    if (levelref is AdventureTimeGamePB) {
      pBlevel = levelref as AdventureTimeGamePB;
      timeLimit = 0.5;
    } else if (levelref is AdventureTimeGameIK) {
      iKlevel = levelref as AdventureTimeGameIK;
      timeLimit = 0.8;
    }
    spawnLevel = 0;
    time = 2.0;
    random = Random();
    timer = Timer(time, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  void spawnRandomEnemy() {
    final randomint = random.nextInt(amuntOfEnemies);

    if (pBlevel != null) {
      final randomEnemyType = EnemyTypePB.values.elementAt(randomint);
      final newEnemy = EnemyPB(
        enemyType: randomEnemyType,
        level: levelref,
        speed: speed,
      );
      pBlevel?.add(newEnemy);
      // debugPrint(newEnemy.enemyData.speed.toString());
    } else if (iKlevel != null) {
      final randomEnemyType = EnemyTypeIK.values.elementAt(randomint);
      final newEnemy = EnemyIK(
        enemyType: randomEnemyType,
        level: levelref,
        speed: speed,
      );
      iKlevel?.add(newEnemy);
      // debugPrint(newEnemy.enemyData.speed.toString());
    }
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);

    timer.update(dt);

    if (time >= timeLimit) {
      var newSpawnLevel =
          pBlevel == null ? iKlevel!.ikscore ~/ 200 : pBlevel!.pbscore ~/ 200;

      if (spawnLevel < newSpawnLevel) {
        spawnLevel = newSpawnLevel;

        timer.stop();

        time = 2 / (1 + (spawnLevel * 0.1));

        timer = Timer(time, repeat: true, onTick: () {
          spawnRandomEnemy();
        });

        timer.start();
      }
    }

    if (speed < 1000) {
      speed += ((dt) * 10);
      // debugPrint(speed.toString());
    }
  }
}
