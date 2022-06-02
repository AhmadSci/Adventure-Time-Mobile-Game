import 'package:adventure_time_game/screens/main_menu.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  FlameAudio.audioCache.load('button.wav');
  FlameAudio.audioCache.load('Ambient Music.wav');
  FlameAudio.bgm.play('Ambient Music.wav', volume: .5);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainMenu(),
    ),
  );
}
