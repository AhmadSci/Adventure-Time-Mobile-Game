// ignore_for_file: file_names

import 'package:adventure_time_game/game/levels/IK/ik_boss.dart';
import 'package:adventure_time_game/screens/win_menu.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';

import '../../finn.dart';
import '../../enemy_manager.dart';
import '../../settings/levels_constants.dart';
import '../../../screens/game_over_menu.dart';

class AdventureTimeGameIK extends FlameGame
    with TapDetector, HasCollisionDetection {
  // class variables
  late int ikscore;
  late EnemyManager enemyManager;
  int counter = 0;
  int doubleTap = 0;
  late Finn player;
  late ParallaxComponent background;
  IKBoss boss = IKBoss();

  @override
  Future<void> onLoad() async {
    // load all needed sound effects to cache
    await FlameAudio.audioCache.load('jump.wav');
    await FlameAudio.audioCache.load('hurt.wav');
    await FlameAudio.audioCache.load('death.wav');

    // setting the paralanx background and adding it to the game
    background = await loadParallaxComponent(
      [
        ParallaxImageData('ICE/iceKingdom/sky.png'),
        ParallaxImageData('ICE/iceKingdom/far.png'),
        ParallaxImageData('ICE/iceKingdom/front.png'),
      ],
      fill: LayerFill.none,
      baseVelocity: Vector2(paralaxSpeed, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
    );
    add(background);

    // setting the player, his animation, and adding him to the game
    player = Finn(
      animation: await Finn.idle(),
      hagm: Vector2.all(80.0),
      yMax: size.y - 35 * 2,
      levelref: this,
    );
    player.startAnimation(this);
    add(player);

    // setting the enemy manager for this level
    enemyManager = EnemyManager(3, this);
    add(enemyManager);

    // initialising the score for this level and adding it to the game
    ikscore = 0;
    IKscoreText.text = ikscore.toString();

    add(IKscoreText);

    // initialising the collision counter of the player for this level
    IKcollisions.text = "0";
    add(IKcollisions);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    // on screen tap, the player jumps
    if (doubleTap < 1) {
      player.jump(this);
      doubleTap++;
      if (player.isOnGround()) {
        doubleTap = 0;
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // if the is dead, display the game over menu, pause the game, and save the score
    if (player.collisionCount >= 5) {
      overlays.add(GameOverMenu.id);
      FlameAudio.play('death.wav');
      pauseEngine();
      saveScore(ikscore);
      // debugPrint("Game Over");
    }

    // gradually increase the score and update the score text
    ikscore += (60 * dt).toInt();
    IKscoreText.text = ikscore.toString();
    IKscoreText.position = Vector2(
      (size.x / 2) - (IKscoreText.width / 2),
      size.y / 13,
    );

    // gradually increase the speed of the background
    if (paralaxSpeed < 250) {
      paralaxSpeed += dt;
      // debugPrint(paralaxSpeed.toString());
    }
    background.parallax?.baseVelocity = Vector2(paralaxSpeed, 0);

    // updating the collisions counter for each frame of the game
    IKcollisions.text = player.collisionCount.toString();

    // resetting the double jump constraint if the player is on the ground
    if (player.isOnGround()) {
      doubleTap = 0;
    }

    // if the player reaches a certain score, the boss appears
    if (ikscore == 4000) {
      add(boss);
      remove(enemyManager);
    }

    // if the player has defeated the boss, display the win menu, pause the game, and save the score
    if (boss.isDead) {
      overlays.add(WinMenu.id);
      FlameAudio.play('death.wav');
      pauseEngine();
      saveScore(ikscore);
    }

    // debugPrint(counter.toString());
  }
}
