// ignore_for_file: avoid_init_to_null

/* 
*******************************************************************************

          a class that manages the process of spawning enemies

*******************************************************************************
*/

import 'dart:math';

import 'package:adventure_time_game/game/levels/PB/enemy_pb.dart';
import 'package:adventure_time_game/game/levels/IK/IKLevel.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'levels/IK/enemy_ik.dart';
import 'levels/PB/PBLevel.dart';

class EnemyManager extends Component {
  // class variables
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
    // check what level the game is on
    if (levelref is AdventureTimeGamePB) {
      pBlevel = levelref as AdventureTimeGamePB;
      timeLimit = 0.5;
    } else if (levelref is AdventureTimeGameIK) {
      iKlevel = levelref as AdventureTimeGameIK;
      timeLimit = 0.8;
    }

    // initialize the random number generator, timer and spawn level
    spawnLevel = 0;
    time = 2.0;
    random = Random();
    timer = Timer(time, repeat: true, onTick: () {
      spawnRandomEnemy();
    });
  }

  // spawns a random enemy
  void spawnRandomEnemy() {
    // creating a random number between 0 and the amount of enemies for this level (witch is sent in the constructor)
    final randomint = random.nextInt(amuntOfEnemies);

    // check what level the game is on, and spawn the enemy based on the level
    if (pBlevel != null) {
      final randomEnemyType = EnemyTypePB.values.elementAt(randomint);

      // creating a new enemy, setting its data and adding it to the level
      final newEnemy = EnemyPB(
        enemyType: randomEnemyType,
        level: levelref,
        speed: speed,
      );
      pBlevel?.add(newEnemy);
    } else if (iKlevel != null) {
      final randomEnemyType = EnemyTypeIK.values.elementAt(randomint);

      // creating a new enemy, setting its data and adding it to the level
      final newEnemy = EnemyIK(
        enemyType: randomEnemyType,
        level: levelref,
        speed: speed,
      );
      iKlevel?.add(newEnemy);
    }
  }

  @override
  void onMount() {
    super.onMount();

    // when the enemy manager is mounted, start the timer
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // update the timer to spawn new enemies
    timer.update(dt);

    // gradually decrease the time between enemies spawning
    if (time >= timeLimit) {
      // calculating the new spawn level for the enemies based on the score
      var newSpawnLevel =
          pBlevel == null ? iKlevel!.ikscore ~/ 200 : pBlevel!.pbscore ~/ 200;

      // setting the new spawn level if it is higher than the current one, decreasing the time between enemies spawning
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

    // limiting the speed of the enemies
    if (speed < 1000) {
      // gradually increasing the speed of the enemies
      speed += ((dt) * 10);
    }
  }
}
