import 'package:flutter/material.dart';

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

List<UserData> userDataList = [
  UserData(username: 'User1', highScore: 1000, rank: 1),
  UserData(username: 'User2', highScore: 800, rank: 2),
  // Add more users as needed
];

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('images/image2.jpeg'), // Adjust the path as needed
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Leaderboard',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'DRAGON'),
              ),
              SizedBox(height: 20),
              DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Rank',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                        color: Colors.white,
                        fontFamily: 'DRAGON',
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'High Score',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                                fontFamily: 'DRAGON',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              userData.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DRAGON',
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              userData.highScore.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DRAGON',
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
