import 'package:flutter/material.dart';

class AchievementsGrid extends StatelessWidget {
  final double progress;

  AchievementsGrid({required this.progress});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return _buildAchievementItem(index);
      },
    );
  }

  GestureDetector _buildAchievementItem(int index) {
    final icons = [
      Icons.public,
      Icons.location_on,
      Icons.star,
      Icons.map,
      Icons.settings,
      Icons.eco,
    ];

    Color liquidColor = Color.lerp(Colors.green, Colors.blue, progress)!;

    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.blue.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(4, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.7),
              blurRadius: 8,
              offset: Offset(-4, -4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Colors.green.shade400, liquidColor],
                  radius: 0.7,
                  center: Alignment.center,
                ),
              ),
            ),
            Icon(
              icons[index],
              size: 50,
              color: Colors.white,
            ),
            Positioned(
              bottom: 8,
              child: Text(
                "${(progress * 100).toInt()}%",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
