import 'package:get/get.dart';

class ScoreController extends GetxController {
  RxInt score = 0.obs;

  void updateScore(int newScore) {
    score.value = newScore;
    score.update((val) => val = newScore);
    //You can also put the feature to save the score to shared preferences here
  }
}
