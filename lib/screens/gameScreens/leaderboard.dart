import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class UserData {
  final String username;
  final int highScore;
  final int rank;

  UserData({
    required this.username,
    required this.highScore,
    required this.rank,
  });
}

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<UserData> userDataList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchHighScores();
  }

  Future<void> _fetchHighScores() async {
    var database = FirebaseFirestore.instance;
    try {
      var querySnapshot = await database
          .collection('highScores')
          .orderBy('score', descending: true)
          .limit(10)
          .get();

      List<UserData> newList = [];
      int rank = 1;
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;
        var user = UserData(
          username: data['name'],
          highScore: data['score'],
          rank: rank,
        );
        newList.add(user);
        rank++;
      });

      setState(() {
        userDataList = newList;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/image2.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.8),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Leaderboard',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'DRAGON',
                        ),
                      ),
                      SizedBox(height: 20),
                      Flexible(
                        child: DataTable(
                          columns: [
                            DataColumn(
                              label: Text(
                                'Rank',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'DRAGON',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'DRAGON',
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'HighScore',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontFamily: 'DRAGON',
                                ),
                              ),
                            ),
                          ],
                          rows: userDataList
                              .map(
                                (userData) => DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        userData.rank.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'DRAGON',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        userData.username,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'DRAGON',
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        userData.highScore.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'DRAGON',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: BounceInLeft(
                          child: GameScreenButton(
                            onTap: () {
                              Get.back();
                            },
                            label: 'Go Back',
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
