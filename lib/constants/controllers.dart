import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreController extends GetxController {
  RxInt score = 0.obs;
  RxDouble ballSpeed = 200.0.obs;
  RxInt totalLife = 3.obs;
  List allLevels = [];
  int selectedLevelIndex = 0;
  final String _scoreKey = 'score'; // Key for SharedPreferences

  void initAllLevels(List levels) {
    allLevels.addAll(levels);    
  }

  void nextLevel() {
    selectedLevelIndex++;
  }

  void updateSelectedLevels(int index) {
    selectedLevelIndex = index;
  }

  void updateScore(int newScore) {
    score.value = newScore;
    _saveScoreToSharedPreferences(newScore);
  }

  resetBallSpeed() {
    ballSpeed = 200.0.obs;
  }

  void increaseScore(int newscore) {
    int tempScore = score.value;
    tempScore += newscore;
    updateScore(tempScore);
  }

  void adjustBallSpeed(double newBallSpeed) {
    ballSpeed.value += newBallSpeed;
    ballSpeed.refresh();
  }

  bool checkLife() {
    return totalLife.value >= 0;
  }

  void increaseLife() {
    totalLife.value++;
  }

  void decreaseLife() {
    totalLife.value--;
  }

  // Save the score to SharedPreferences
  Future<void> _saveScoreToSharedPreferences(int newScore) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_scoreKey, newScore);
  }

  // Retrieve the score from SharedPreferences
  Future<void> getScoreFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedScore = prefs.getInt(_scoreKey) ?? 0;
    score.value = savedScore;
  }
}
