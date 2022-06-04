// ignore_for_file: non_constant_identifier_names

/* 
*******************************************************************************

   this file stores all the repeatedly used functions/variables for the game

*******************************************************************************
*/

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// background speed
double paralaxSpeed = 70;

// text style
late TextPaint textPaint = TextPaint(
  style: const TextStyle(
    fontSize: 35.0,
    fontFamily: 'Pixely',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);

// text components for the score and collisions
TextComponent PBscoreText = TextComponent(
  size: Vector2.all(50.0),
  textRenderer: textPaint,
)..anchor = Anchor.center;

TextComponent IKscoreText = TextComponent(
  size: Vector2.all(50.0),
  textRenderer: textPaint,
)..anchor = Anchor.center;

TextComponent IKcollisions = TextComponent(
  size: Vector2.all(50.0),
  textRenderer: textPaint,
);
TextComponent PBcollisions = TextComponent(
  size: Vector2.all(50.0),
  textRenderer: textPaint,
);

// saves the score to the shared preferences
saveScore(int score) async {
  // creating an instance of shared preferences
  final prefs = await SharedPreferences.getInstance();

  // getting the already saved scores, if any
  final score1 = prefs.getInt("hscore1") ?? 0;
  final score2 = prefs.getInt("hscore2") ?? 0;
  final score3 = prefs.getInt("hscore3") ?? 0;

  // setting the keys for the scores for later use
  var key1 = "hscore1";
  var key2 = "hscore2";
  var key3 = "hscore3";

  if (score1 == 0) {
    // if the first score is not set, set it
    prefs.setInt(key1, score);
  } else if (score2 == 0 && score1 != 0) {
    // if the second score is not set,and current score is greater than the first one, set the first score to the second score, and set the current score to the first score
    if (score1 < score) {
      prefs.setInt(key2, score1);
      prefs.setInt(key1, score);
    } else {
      // if the current score is less than the first score, set the current score to the second score
      prefs.setInt(key2, score);
    }
  } else if (score3 == 0 && score2 != 0 && score1 != 0) {
    // if the third score is not set, while all the others are, set it.
    if (score1 < score) {
      // if the first score is less than the current score, set the first score to the second score, the second to the thirs, and set the current score to the first score
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score1);
      prefs.setInt(key1, score);
    } else if (score2 < score) {
      // if the second score is less than the current score, set the second score to the third score, and set the current score to the second score
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score);
    } else {
      // if the current score is the smallest, set the current score to the third score
      prefs.setInt(key3, score);
    }
  } else {
    // if all the scores are set, check if the current score is greater than any of the scores, and if it is, replace the lowest score with the current score
    if (score1 < score) {
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score1);
      prefs.setInt(key1, score);
    } else if (score2 < score) {
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score);
    } else if (score3 < score) {
      prefs.setInt(key3, score);
    }
  }
  debugPrint('saved $score');
}
