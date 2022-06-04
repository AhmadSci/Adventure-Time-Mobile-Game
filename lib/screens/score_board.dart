/* 
*******************************************************************************

                A widget to display the ScoreBoard screen

*******************************************************************************
*/

import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_menu.dart';

class ScoreBoard extends StatefulWidget {
  ScoreBoard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScoreBoardState();
  }
}

class ScoreBoardState extends State<ScoreBoard> {
  // setting the variables
  late Future<int> score1;
  late Future<int> score2;
  late Future<int> score3;

  // getting an instrance of shared preferences
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    // getting the scores from shared preferences
    score1 = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('hscore1') ?? 0;
    });
    score2 = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('hscore2') ?? 0;
    });
    score3 = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('hscore3') ?? 0;
    });
  }

  // this function displays the scores on the screen using future builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(97, 255, 255, 255),
      body: Stack(
        children: <Widget>[
          //  'pr-2'
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/scoreboard-bg.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width / 0.79,
            top: MediaQuery.of(context).size.width * 0.08,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: FutureBuilder<int>(
                      future: score1,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                '- ${snapshot.data}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pixely",
                                ),
                              );
                            }
                        }
                      },
                    ),
                  ),
                ]),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width / 0.79,
            top: MediaQuery.of(context).size.width * 0.11,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: FutureBuilder<int>(
                      future: score2,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                '- ${snapshot.data}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pixely",
                                ),
                              );
                            }
                        }
                      },
                    ),
                  ),
                ]),
          ),

          Positioned(
            width: MediaQuery.of(context).size.width / 0.79,
            top: MediaQuery.of(context).size.width * 0.14,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: FutureBuilder<int>(
                      future: score3,
                      builder:
                          (BuildContext context, AsyncSnapshot<int> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const CircularProgressIndicator();
                          default:
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text(
                                '- ${snapshot.data}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Pixely",
                                ),
                              );
                            }
                        }
                      },
                    ),
                  ),
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
                        'Back',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontFamily: "Pixely",
                        ),
                      ),
                      onPressed: () {
                        FlameAudio.play('button.wav');
                        Navigator.of(context).pushReplacement(PageRouteBuilder(
                          pageBuilder: (_, __, ___) => MainMenu(),
                        ));
                      },
                      style: ButtonStyle(
                        enableFeedback: false,
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(180, 255, 255, 255)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                    side: BorderSide(
                                        color: Color.fromARGB(
                                            255, 255, 255, 255)))),
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
