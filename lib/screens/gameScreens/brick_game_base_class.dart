import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';

abstract class BrickGameBaseClass extends FlameGame {
  BrickGameBaseClass();
  int score = 0;

  AudioPlayer gameOverSound = AudioPlayer();
  AudioPlayer levelCompleteSound = AudioPlayer();
  // AudioPlayer levelMusic = AudioPlayer();

  @override
  FutureOr<void> onLoad() async {
    await gameOverSound.setSource(AssetSource('audio/gameover2.wav'));
    await levelCompleteSound.setSource(AssetSource('audio/level_complete.wav'));
    // await levelMusic.setSource(AssetSource('audio/level_music.wav'));
    // await levelMusic.resume();
    return super.onLoad();
  }

  void gameOver() async {
    await gameOverSound.resume();
  }
}
