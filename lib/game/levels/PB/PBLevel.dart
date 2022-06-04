// ignore_for_file: file_names

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';

import '../../../screens/game_over_menu.dart';
import '../../settings/levels_constants.dart';
import '../../finn.dart';
import '../../enemy_manager.dart';

class AdventureTimeGamePB extends FlameGame
    with TapDetector, HasCollisionDetection {
  // class variables
  late int pbscore;
  late EnemyManager enemyManager;
  int counter = 0;
  late Finn player;
  late ParallaxComponent background;

  @override
  Future<void> onLoad() async {
    // load all needed sound effects to cache
    await FlameAudio.audioCache.load('jump.wav');
    await FlameAudio.audioCache.load('hurt.wav');
    await FlameAudio.audioCache.load('death.wav');

    // setting the paralanx background and adding it to the game
    background = await loadParallaxComponent(
      [
        ParallaxImageData('gumParalax/sky.png'),
        ParallaxImageData('gumParalax/bg-4.png'),
        ParallaxImageData('gumParalax/bg-2.png'),
        ParallaxImageData('gumParalax/bg-1.png'),
      ],
      baseVelocity: Vector2(paralaxSpeed, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
      fill: LayerFill.none,
    );
    add(background);

    // setting the player, his animation, and adding him to the game
    player = Finn(
      animation: await Finn.idle(),
      hagm: Vector2.all(80),
      yMax: size.y - 35 * 2,
      levelref: this,
    );
    player.startAnimation(this);
    add(player);

    // setting the enemy manager for this level
    enemyManager = EnemyManager(3, this);
    add(enemyManager);

    // initialising the score for this level and adding it to the game
    pbscore = 0;
    PBscoreText.text = pbscore.toString();
    add(PBscoreText);

    // initialising the collision counter of the player for this level
    PBcollisions.text = "0";
    add(PBcollisions);
  }

  int doubleTap = 0;

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
      saveScore(pbscore);
    }

    // resetting the double jump constraint if the player is on the ground
    if (player.isOnGround()) {
      doubleTap = 0;
    }

    // gradually increase the score and update the score text
    pbscore += (60 * dt).toInt();
    PBscoreText.text = pbscore.toString();
    PBscoreText.position = Vector2(
      (size.x / 2) - (PBscoreText.width / 2),
      size.y / 13,
    );

    // gradually increase the speed of the background
    if (paralaxSpeed < 250) {
      paralaxSpeed += dt;
      // debugPrint(paralaxSpeed.toString());
    }
    background.parallax?.baseVelocity = Vector2(paralaxSpeed, 0);

    // updating the collisions counter for each frame of the game
    PBcollisions.text = player.collisionCount.toString();
  }
}
