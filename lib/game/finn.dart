// ignore_for_file: avoid_init_to_null

/* 
*******************************************************************************

                this class manages the player's behavior

*******************************************************************************
*/

import 'package:adventure_time_game/game/levels/IK/ik_boss.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

import 'levels/IK/IKLevel.dart';
import 'levels/IK/enemy_ik.dart';
import 'levels/PB/enemy_pb.dart';
import 'levels/PB/PBLevel.dart';

class Finn extends SpriteAnimationComponent with CollisionCallbacks {
  // class variables
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

  Finn({
    required this.animation,
    required this.hagm,
    required this.yMax,
    required this.levelref,
  }) {
    // check what level the game is on
    if (levelref is AdventureTimeGamePB) {
      pBlevel = levelref as AdventureTimeGamePB;
    } else if (levelref is AdventureTimeGameIK) {
      iKlevel = levelref as AdventureTimeGameIK;
    }
    anchor = Anchor.center;
  }

  // saving sprite data for the animation of the player
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

  // setting the animations of the player
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

  // handling the player's jumping behavior
  Future<void> jump(FlameGame game) async {
    // setting the strength of the jump
    speedY = -700;

    // changing the jumping state to true
    isJumping = true;

    // playing the jump sound
    FlameAudio.play('jump.wav');

    // setting the animation to the jumping animation if the player is not currently hit
    if (!isHit) {
      animation = await jumpA();
    }

    // starting the jump timer
    _jumpTimer.start();
  }

  // handling the player's hit behavior
  Future<void> hit() async {
    // setting the hit state to true
    isHit = true;

    // incrementing the collision count
    collisionCount++;

    // decrementing the score of the player if the player gets hit
    pBlevel != null ? pBlevel!.pbscore -= 20 : iKlevel!.ikscore -= 20;

    // playing the hit sound
    FlameAudio.play('hurt.wav');

    // setting the animation to the hit animation
    animation = await hitA();

    // starting the hit timer
    _hitTimer.start();
  }

  // setting the player's initial animation to running
  Future<void> startAnimation(FlameGame game) async {
    // setting the initial animation to the running animation
    animation = await run();

    // initialising the siize of the player
    size = hagm;

    // setting the player's position
    x = game.size.length / 2 - hagm.x * 4.2;
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    // introducing gravity to the player
    speedY += gravity * dt;

    // changing the player's y position based on the speed of the player's jump (after its affected by gravity)
    y += speedY * dt;

    // checking if the player is on the ground
    if (isOnGround()) {
      // setting his position to the ground and jumping strength to 0
      y = yMax;
      speedY = 0.0;
    }

    // updating the hit timer
    _hitTimer.update(dt);

    // updating the jump timer if the player is not currently hit
    if (!isHit) {
      _jumpTimer.update(dt);
    }
  }

  // checks if the player is on the ground
  bool isOnGround() {
    return (y >= yMax);
  }

  @override
  void onMount() {
    super.onMount();

    // setting the player's hitbox
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3),
      ),
    );
    // yMax = y;

    // setting player's animation to the running animation after the hit animation is done
    _hitTimer.onTick = () async {
      animation = await run();
      isHit = false;
    };

    // setting player's animation to the running animation after the jump animation is done
    _jumpTimer.onTick = () async {
      animation = await run();
      isJumping = false;
    };
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    // checks for collisions between the player and the enemies, if so the player gets hit
    if (((other is EnemyPB || other is EnemyIK || other is IKBoss) && !isHit)) {
      hit();
    }
  }
}
