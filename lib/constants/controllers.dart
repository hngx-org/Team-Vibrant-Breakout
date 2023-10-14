import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreController extends GetxController {
  RxInt score = 0.obs;
  final String _scoreKey = 'score'; // Key for SharedPreferences

  void updateScore(int newScore) {
    score.value = newScore;
    _saveScoreToSharedPreferences(newScore);
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
