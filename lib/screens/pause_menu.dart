/* 
*******************************************************************************

                A widget to display the Pause Menu Overlay

*******************************************************************************
*/

import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'main_menu.dart';
import '../game/widgets/overlays/pause_button.dart';

// ignore: must_be_immutable
class PauseMenu extends StatelessWidget {
  // setting the id
  static const String id = 'pause_menu';

  // creating a variable to get a refrence for the game
  late FlameGame gameref;

  PauseMenu({required this.gameref, Key? key}) : super(key: key);

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
                'Paused',
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

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pixely',
                  ),
                ),
                onPressed: () {
                  // on press of resume button, resume the game and remove the overlay
                  FlameAudio.play('button.wav');
                  gameref.resumeEngine();
                  gameref.overlays.add(PauseButton.id);
                  gameref.overlays.remove(id);
                },
                style: ButtonStyle(
                  enableFeedback: false,
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(100, 0, 0, 0)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(color: Colors.blue))),
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
