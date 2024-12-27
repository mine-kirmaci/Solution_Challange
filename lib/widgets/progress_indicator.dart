import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final Animation<double> animation;

  ProgressIndicatorWidget({required this.progress, required this.animation});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50, // İlerleme göstergesinin yeri
      left: 50, // İlerleme göstergesinin yeri
      right: 50, // İlerleme göstergesinin yeri
      child: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return CircularProgressIndicator(
              value: progress * animation.value, // Animasyona bağlı olarak ilerlemeyi gösteriyoruz
              strokeWidth: 10,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400),
            );
          },
        ),
      ),
    );
  }
}
