// ignore_for_file: file_names

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../../screens/game_over_menu.dart';
import '../../settings/levels_constants.dart';
import '../../finn.dart';
import '../../enemy_manager.dart';

class AdventureTimeGamePB extends FlameGame
    with TapDetector, HasCollisionDetection {
  late int pbscore;
  late EnemyManager enemyManager;
  int counter = 0;
  // AdventureTimeGamePB({});

  late Finn player;
  late ParallaxComponent background;

  @override
  Future<void> onLoad() async {
    await FlameAudio.audioCache.load('jump.wav');
    await FlameAudio.audioCache.load('hurt.wav');
    await FlameAudio.audioCache.load('death.wav');
    background = await loadParallaxComponent(
      [
        ParallaxImageData('gumParalax/sky.png'),
        ParallaxImageData('gumParalax/bg-4.png'),
        ParallaxImageData('gumParalax/bg-2.png'),
        ParallaxImageData('gumParalax/bg-1.png'),
      ],
      baseVelocity: Vector2(50, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
      fill: LayerFill.none,
    );
    add(background);

    player = Finn(
      animation: await Finn.idle(),
      hagm: Vector2.all(80),
      yMax: size.y - 35 * 2,
      levelref: this,
    );

    player.startAnimation(this);

    add(player);

    enemyManager = EnemyManager(3, this);
    add(enemyManager);

    pbscore = 0;
    PBscoreText.text = pbscore.toString();

    add(PBscoreText);

    PBcollisions.text = "0";
    add(PBcollisions);
  }

  int doubleTap = 0;

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
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

    if (player.collisionCount >= 5) {
      overlays.add(GameOverMenu.id);
      FlameAudio.play('death.wav');
      pauseEngine();
      saveScore(pbscore);
    }

    if (player.isOnGround()) {
      doubleTap = 0;
    }

    pbscore += (60 * dt).toInt();
    PBscoreText.text = pbscore.toString();
    PBscoreText.position = Vector2(
      (size.x / 2) - (PBscoreText.width / 2),
      size.y / 13,
    );

    PBcollisions.text = player.collisionCount.toString();
  }

  // void _disconnectActors() {
  //   player.removeFromParent();
  //   enemyManager.removeFromParent();
  // }

  // void reset() {
  //   // First disconnect all actions from game world.
  //   _disconnectActors();

  //   // Reset player data to inital values.
  //   player.collisionCount = 0;
  //   // playerData.lives = 5;
  // }
}
