import 'package:flutter/material.dart';
import '../widgets/achievements_grid.dart';
import '../widgets/map_section.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> with SingleTickerProviderStateMixin {
  double currentPoints = 20;
  double totalPoints = 100;

  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _scrollController = ScrollController();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentPoints / totalPoints;  // progress hesaplamasını buraya ekledik
    double appBarOpacity = _calculateAppBarOpacity();

    return Scaffold(
      backgroundColor: Color(0xFFF0FFF4),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(appBarOpacity, progress),  // progress parametresi burada ekleniyor
          _buildMainContent(progress),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  double _calculateAppBarOpacity() {
    double scrollOffset = _scrollController.hasClients ? _scrollController.offset : 0;
    return 1 - (scrollOffset / 200).clamp(0.0, 1.0);
  }

  SliverAppBar _buildSliverAppBar(double appBarOpacity, double progress) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 300.0,
      backgroundColor: Colors.green.withOpacity(appBarOpacity),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            _buildGradientBackground(),
            ProgressIndicatorWidget(progress: progress, animation: _progressAnimation),  // progress parametresi geçiliyor
          ],
        ),
      ),
    );
  }

  Container _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF88D8B0), Color(0xFF3CBBB1)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  SliverList _buildMainContent(double progress) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _buildAchievementsSection(progress),
          _buildExploreMapSection(),
        ],
      ),
    );
  }

  Padding _buildAchievementsSection(double progress) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Your Achievements"),
          SizedBox(height: 10),
          AchievementsGrid(progress: progress),
        ],
      ),
    );
  }

  Padding _buildExploreMapSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Explore the Map"),
          SizedBox(height: 10),
          MapSection(),
        ],
      ),
    );
  }

  Text _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.green.shade800,
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: _incrementPoints,
      backgroundColor: Colors.blue.shade400,
      child: Icon(Icons.add),
    );
  }

  void _incrementPoints() {
    setState(() {
      if (currentPoints < totalPoints) {
        currentPoints += 10;
        _controller.forward(from: 0);  // Restart animation each time points increase
      }
    });
  }

  // Progress indicator widget
  Widget ProgressIndicatorWidget({
    required double progress,
    required Animation<double> animation,
  }) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dıştaki ilerleme çubuğu
          CircularProgressIndicator(
            value: animation.value * progress, // İlerleme oranı, animasyon etkisiyle
            strokeWidth: 15, // Çubuğun kalınlığı
            backgroundColor: Colors.grey.shade300, // Arka plan rengi
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade400),
          ),
          // İç 3D çember
          Container(
            height: 140,
            width: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade200, // Üst kısım açık renk
                  Colors.grey.shade400, // Alt kısım koyu renk
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                // Dış gölge (sağ alt)
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(6, 6),
                ),
                // İç gölge (sol üst)
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 15,
                  offset: Offset(-6, -6),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.public,
                size: 60,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
