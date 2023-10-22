import 'package:flame/components.dart';

class Background extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('breakout_bg.png');
    size = game.size;
    position = Vector2.zero();
    priority = 0;
  }
}
