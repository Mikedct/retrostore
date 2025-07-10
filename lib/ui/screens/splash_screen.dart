import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:retrostore/ui/screens/main_game_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('img/RetroStore.png'), // pastikan gambar tersedia
            ),
          ),
          SizedBox(height: 20),
          Text(
            'RetroStore',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
      nextScreen: const MainGameScreen(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: Colors.black,
      duration: 2500,
    );
  }
}
