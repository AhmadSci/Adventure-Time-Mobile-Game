// ignore_for_file: non_constant_identifier_names

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late TextPaint textPaint = TextPaint(
  style: const TextStyle(
    fontSize: 35.0,
    fontFamily: 'Pixely',
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);

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

saveScore(int score) async {
  final prefs = await SharedPreferences.getInstance();
  final score1 = prefs.getInt("hscore1") ?? 0;
  final score2 = prefs.getInt("hscore2") ?? 0;
  final score3 = prefs.getInt("hscore3") ?? 0;
  var key1 = "hscore1";
  var key2 = "hscore2";
  var key3 = "hscore3";
  if (score1 == 0) {
    prefs.setInt(key1, score);
  } else if (score2 == 0 && score1 != 0) {
    if (score1 < score) {
      prefs.setInt(key2, score1);
      prefs.setInt(key1, score);
    } else {
      prefs.setInt(key2, score);
    }
  } else if (score3 == 0 && score2 != 0 && score1 != 0) {
    if (score1 < score) {
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score1);
      prefs.setInt(key1, score);
    } else if (score2 < score) {
      prefs.setInt(key3, score2);
      prefs.setInt(key2, score);
    } else {
      prefs.setInt(key3, score);
    }
  } else {
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
