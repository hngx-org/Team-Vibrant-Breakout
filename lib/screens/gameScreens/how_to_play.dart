import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Retro Breakout',
          style: TextStyle(
            fontFamily: 'DRAGON',
            fontSize: 24.0,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade800,
                Colors.blue.shade900,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'How to Play',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'ARCADECLASSIC',
                  ),
                ),
              ),
              const SizedBox(height: 20.0), // Add spacing after heading
              _buildInstructionStep(
                'Launch the Game',
                'Open the breakout game application',
              ),
              _buildInstructionStep(
                'Start the Game',
                'Click the "Play" button to begin.',
              ),
              _buildInstructionStep(
                'Control the Paddle',
                'Use the left and right arrow keys on your keyboard to move the paddle, or tap on left or right side of your screen to move the paddle.',
              ),
              _buildInstructionStep(
                'Hit the Ball',
                'Position the paddle to hit the ball when it bounces down.',
              ),
              _buildInstructionStep(
                'Break the Bricks',
                'The ball breaks bricks upon impact, earning you points.',
              ),
              _buildInstructionStep(
                'Prevent Ball from Falling',
                'Keep the ball from falling off the bottom edge of the screen using the paddle.',
              ),
              _buildInstructionStep(
                'Catch Power-Ups (if available)',
                'Some games offer power-ups for advantages like enlarging the paddle or special ball effects.',
              ),
              _buildInstructionStep(
                'Complete the Level',
                'Clear all bricks to advance to the next level with new challenges.',
              ),
              _buildInstructionStep(
                'Lose a Life',
                'If the ball falls off the screen, you lose a life. You have a limited number of lives.',
              ),
              _buildInstructionStep(
                'Game Over',
                'Losing all lives ends the game. You may restart or return to the main menu.',
              ),
              _buildInstructionStep(
                'Achieve High Scores',
                'Strive for high scores by breaking as many bricks as possible.',
              ),
              _buildInstructionStep(
                'Enjoy Special Features (if available)',
                'Some games may have unique brick types or level designs.',
              ),
              _buildInstructionStep(
                'Pause or Quit the Game',
                'Pause with a pause button in the game menu. Quit to return to the main menu.',
              ),
              _buildInstructionStep(
                'Practice and Improve',
                'Practice improves your hand-eye coordination and strategy.',
              ),
              _buildInstructionStep(
                'Have Fun!',
                'Enjoy the game for relaxation and skill-building.',
              ),
              const SizedBox(height: 20.0), // Add some spacing at the end
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.circle, size: 10, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'ARCADECLASSIC',
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontFamily: 'ARCADECLASSIC',
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InstructionsScreen(),
  ));
}
