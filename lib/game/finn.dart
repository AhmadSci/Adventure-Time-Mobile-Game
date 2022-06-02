import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'levels/IK/IKLevel.dart';
import 'levels/IK/enemy_ik.dart';
import 'levels/PB/enemy_pb.dart';
import 'levels/PB/PBLevel.dart';

class Finn extends SpriteAnimationComponent with CollisionCallbacks {
  @override
  // ignore: overridden_fields
  SpriteAnimation? animation;

  bool isHit = false;
  bool isJumping = false;

  late AdventureTimeGamePB? pBlevel = null;
  late AdventureTimeGameIK? iKlevel = null;
  late FlameGame levelref;

  final Timer _hitTimer = Timer(.4);
  final Timer _jumpTimer = Timer(0.8);

  double speedY = 0.0;
  double yMax;
  late Vector2 hagm;
  late int collisionCount = 0;

  double gravity = 1700;

  Finn(
      {required this.animation,
      required this.hagm,
      required this.yMax,
      required this.levelref}) {
    if (levelref is AdventureTimeGamePB) {
      pBlevel = levelref as AdventureTimeGamePB;
    } else if (levelref is AdventureTimeGameIK) {
      iKlevel = levelref as AdventureTimeGameIK;
    }
    anchor = Anchor.center;
  }

  static final runningSprites = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map(
    (i) => Sprite.load('walk/Untitled-$i.png'),
  );

  static final hitSprites = [1, 2, 3, 4].map(
    (i) => Sprite.load('hurt/Untitled-$i.png'),
  );

  static final idleSprites = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].map(
    (i) => Sprite.load('idle/Untitled-$i.png'),
  );

  static final jumpSprites = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
    (i) => Sprite.load('jump/Untitledj$i.png'),
  );

  static Future<SpriteAnimation> idle() async {
    return SpriteAnimation.spriteList(
      await Future.wait(idleSprites),
      stepTime: 0.1,
    );
  }

  static Future<SpriteAnimation> hitA() async {
    return SpriteAnimation.spriteList(
      await Future.wait(hitSprites),
      stepTime: 0.1,
    );
  }

  static Future<SpriteAnimation> run() async {
    return SpriteAnimation.spriteList(
      await Future.wait(runningSprites),
      stepTime: 0.05,
    );
  }

  static Future<SpriteAnimation> jumpA() async {
    return SpriteAnimation.spriteList(
      await Future.wait(jumpSprites),
      stepTime: 0.08,
    );
  }

  Future<void> jump(FlameGame game) async {
    speedY = -700;
    isJumping = true;
    // AudioManager.instance.playSfx('hurt7.wav');
    if (!isHit) {
      FlameAudio.play('jump.wav');
      animation = await jumpA();
    }
    _jumpTimer.start();
  }

  Future<void> hit() async {
    isHit = true;
    collisionCount++;
    pBlevel != null ? pBlevel!.pbscore -= 20 : iKlevel!.ikscore -= 20;
    FlameAudio.play('hurt.wav');
    animation = await hitA();
    _hitTimer.start();
  }

  Future<void> startAnimation(FlameGame game) async {
    animation = await run();
    size = hagm;
    x = game.size.length / 2 - hagm.x * 4.2;
    // y = (game.size.length / 2 - hagm.y * 4) / 2;
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    speedY += gravity * dt;

    y += speedY * dt;

    if (isOnGround()) {
      y = yMax;
      speedY = 0.0;
    }
    _hitTimer.update(dt);
    if (!isHit) {
      _jumpTimer.update(dt);
    }
  }

  bool isOnGround() {
    return (y >= yMax);
  }

  @override
  void onMount() {
    super.onMount();

    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3),
      ),
    );
    // yMax = y;

    _hitTimer.onTick = () async {
      animation = await run();
      isHit = false;
    };
    _jumpTimer.onTick = () async {
      animation = await run();
      isJumping = false;
    };
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (((other is EnemyPB || other is EnemyIK) && !isHit)) {
      hit();
    }
  }

  // void reset() [

  // ]
}
