import 'package:adventure_time_game/game/levels/IK/IKLevel.dart';
import 'package:adventure_time_game/screens/game_over_menu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/widgets/overlays/pause_button.dart';
import 'pause_menu.dart';

AdventureTimeGameIK myGame = AdventureTimeGameIK();
// ignore: must_be_immutable

class IceGamePlay extends StatelessWidget {
  IceGamePlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      // This will dislpay a loading bar until [DinoRun] completes
      // its onLoad method.
      loadingBuilder: (conetxt) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/loading.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      // Register all the overlays that will be used by this game.
      // By default MainMenu overlay will be active.
      game: myGame,
      initialActiveOverlays: const [PauseButton.id],
      overlayBuilderMap: {
        PauseButton.id: (BuildContext conext, AdventureTimeGameIK gamme) =>
            PauseButton(gameref: myGame),
        PauseMenu.id: (BuildContext conext, AdventureTimeGameIK game) =>
            PauseMenu(
              gameref: myGame,
            ),
        GameOverMenu.id: (BuildContext conext, AdventureTimeGameIK game) =>
            GameOverMenu(
              gameref: myGame,
            ),
      },
    );
  }
}
