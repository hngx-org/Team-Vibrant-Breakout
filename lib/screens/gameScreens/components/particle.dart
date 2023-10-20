import 'package:flame/components.dart';
import 'package:flame/particles.dart';

class Particles extends ParticleSystemComponent {
  Particles({
    required this.currentParticle,
    required this.currentPosition,
  }) : super(
          particle: currentParticle,
          position: currentPosition,
        );

  Particle currentParticle;
  Vector2 currentPosition;
}
