import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../../../screens/pause_menu.dart';

// ignore: must_be_immutable
class PauseButton extends StatelessWidget {
  static const String id = 'pause_button';

  late FlameGame gameref;

  PauseButton({required this.gameref, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: const Icon(
          Icons.pause,
          color: Colors.black,
        ),
        onPressed: () {
          FlameAudio.play('button.wav');
          gameref.pauseEngine();
          gameref.overlays.add(PauseMenu.id);
          gameref.overlays.remove(id);
        },
      ),
    );
  }
}
