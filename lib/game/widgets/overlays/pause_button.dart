/* 
*******************************************************************************
                            pause button widget
*******************************************************************************
*/

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import '../../../screens/pause_menu.dart';

// ignore: must_be_immutable
class PauseButton extends StatelessWidget {
  // setting an id
  static const String id = 'pause_button';

  // creating a variable to get a refrence for the game
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
          // on button press, pause the game and show the pause menu
          FlameAudio.play('button.wav');
          gameref.pauseEngine();
          gameref.overlays.add(PauseMenu.id);
          gameref.overlays.remove(id);
        },
      ),
    );
  }
}
