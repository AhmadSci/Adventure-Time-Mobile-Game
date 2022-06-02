// ignore_for_file: file_names

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flame_audio/flame_audio.dart';

import '../../finn.dart';
import '../../enemy_manager.dart';
import '../../settings/levels_constants.dart';
import '../../../screens/game_over_menu.dart';

class AdventureTimeGameIK extends FlameGame
    with TapDetector, HasCollisionDetection {
  late int ikscore;
  late EnemyManager enemyManager;
  int counter = 0;

  late Finn player;
  late ParallaxComponent background;

  @override
  Future<void> onLoad() async {
    // FlameAudio.audioCache.clear('Ambient Music.wav');
    await FlameAudio.audioCache.load('jump.wav');
    await FlameAudio.audioCache.load('hurt.wav');
    await FlameAudio.audioCache.load('death.wav');
    background = await loadParallaxComponent(
      [
        ParallaxImageData('ICE/iceKingdom/sky.png'),
        ParallaxImageData('ICE/iceKingdom/far.png'),
        ParallaxImageData('ICE/iceKingdom/front.png'),
      ],
      fill: LayerFill.none,
      baseVelocity: Vector2(100, 0),
      velocityMultiplierDelta: Vector2(1.5, 0),
    );
    add(background);

    player = Finn(
      animation: await Finn.idle(),
      hagm: Vector2.all(80.0),
      yMax: size.y - 35 * 2,
      levelref: this,
    );

    player.startAnimation(this);

    add(player);

    enemyManager = EnemyManager(3, this);
    add(enemyManager);

    ikscore = 0;
    IKscoreText.text = ikscore.toString();

    add(IKscoreText);

    IKcollisions.text = "0";
    add(IKcollisions);
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
      saveScore(ikscore);
    }

    ikscore += (60 * dt).toInt();
    IKscoreText.text = ikscore.toString();
    IKscoreText.position = Vector2(
      (size.x / 2) - (IKscoreText.width / 2),
      size.y / 13,
    );

    IKcollisions.text = player.collisionCount.toString();

    if (player.isOnGround()) {
      doubleTap = 0;
    }

    // debugPrint(counter.toString());
  }
}
