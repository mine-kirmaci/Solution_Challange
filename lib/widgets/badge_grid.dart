import 'package:flutter/material.dart';

class BadgeGridWidget extends StatelessWidget {
  const BadgeGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 20,
      ),
      itemCount: 6, // 6 rozet
      itemBuilder: (context, index) {
        return _buildBadge(index);
      },
    );
  }

  Widget _buildBadge(int index) {
    final icons = [
      Icons.public,
      Icons.location_on,
      Icons.star,
      Icons.map,
      Icons.settings,
      Icons.eco,
    ];

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Colors.green, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          icons[index],
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
