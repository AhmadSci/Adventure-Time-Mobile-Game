import 'dart:ui';

import 'package:adventure_time_game/screens/score_board.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'level_chooser.dart';

class MainMenu extends StatelessWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          //  'pr-2'
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: .6, sigmaY: .6),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
            // margin: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 46.0),
          ),

          Positioned(
            top: MediaQuery.of(context).size.width * 0.0001,
            right: MediaQuery.of(context).size.width / 1.55,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: MediaQuery.of(context).size.width / 3,
                    image: const AssetImage('assets/images/logoin.png'),
                  ), // fit: BoxFit.fill,
                ]),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.width * 0.29,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: ElevatedButton(
                      child: const Text(
                        'START',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pixely',
                        ),
                      ),
                      onPressed: () {
                        FlameAudio.play('button.wav');
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Levels(),
                        ));
                      },
                      style: ButtonStyle(
                        enableFeedback: false,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(100, 0, 0, 0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: const BorderSide(color: Colors.red))),
                      ),
                    ),
                  ), // fit: BoxFit.fill,
                ]),
          ),

          Positioned(
            top: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: ElevatedButton(
                    child: const Text(
                      'Scoreboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Pixely',
                      ),
                    ),
                    onPressed: () {
                      FlameAudio.play('button.wav');
                      Navigator.of(context).pushReplacement(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ScoreBoard(),
                      ));
                    },
                    style: ButtonStyle(
                      enableFeedback: false,
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(124, 245, 6, 6)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12),
                                  bottomRight: Radius.circular(12)),
                              side: BorderSide(color: Colors.red))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
