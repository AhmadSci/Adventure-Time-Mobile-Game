/* 
*******************************************************************************

                A widget to display the GameOver Overlay

*******************************************************************************
*/

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'main_menu.dart';

// ignore: must_be_immutable
class GameOverMenu extends StatelessWidget {
  // setting an id
  static const String id = 'game_over_menu';

  // creating a variable to get a refrence for the game
  late FlameGame gameref;

  GameOverMenu({required this.gameref, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black26),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Game title.
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Game Over',
                style: TextStyle(
                  fontFamily: "Pixely",
                  fontSize: 80.0,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 20.0,
                      color: Colors.white,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                child: const Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pixely',
                  ),
                ),
                onPressed: () {
                  // on button press, return to the main screen and resume the main screen music
                  FlameAudio.play('button.wav');
                  Navigator.of(context).pushReplacement(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => MainMenu(),
                  ));
                  FlameAudio.bgm.resume();
                },
                style: ButtonStyle(
                  enableFeedback: false,
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(100, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(color: Colors.red))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
