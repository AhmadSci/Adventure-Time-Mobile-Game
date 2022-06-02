import 'dart:ui';

import 'package:adventure_time_game/screens/bubblegum_level.dart';
import 'package:adventure_time_game/screens/main_menu.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'ice_level.dart';

class Levels extends StatelessWidget {
  Levels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: [
          //  '2'
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background brmo.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2),
            child: const Center(
              child: Text(
                "Levels",
                style: TextStyle(
                  fontSize: 70.0,
                  fontFamily: "Pixely",
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.width * 0.26,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      child: const Text('Princess Bubblegum',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Pixely',
                          )),
                      onPressed: () {
                        FlameAudio.play('button.wav');
                        FlameAudio.bgm.pause();
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => PBGamePlay(),
                        ));
                      },
                      style: ButtonStyle(
                        enableFeedback: false,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(182, 14, 66, 122)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 6, 140)))),
                      ),
                    ),
                  ), // fit: BoxFit.fill,
                ]),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.width * 0.2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      child: const Text('Ice Kingdom',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Pixely',
                          )),
                      onPressed: () {
                        FlameAudio.play('button.wav');
                        FlameAudio.bgm.pause();
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => IceGamePlay(),
                        ));
                      },
                      style: ButtonStyle(
                        enableFeedback: false,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(182, 14, 66, 122)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 6, 140)))),
                      ),
                    ),
                  ), // fit: BoxFit.fill,
                ]),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width,
            top: MediaQuery.of(context).size.width * 0.34,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: ElevatedButton(
                      child: const Text('Back',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Pixely",
                          )),
                      onPressed: () {
                        FlameAudio.play('button.wav');
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainMenu(),
                        ));
                      },
                      style: ButtonStyle(
                        enableFeedback: false,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(63, 0, 0, 0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 15, 6, 140)))),
                      ),
                    ),
                  ), // fit: BoxFit.fill,
                ]),
          ),
        ],
      ),
    );
  }
}
