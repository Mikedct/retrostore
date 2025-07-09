import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:retrostore/ui/screens/main_recipe_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen ({super.key});
  @override
  Widget build (BuildContext context){
  return AnimatedSplashScreen(
    splash:
    const CircleAvatar (
    radius: 70,
    backgroundColor:Colors.blue,
    child: CircleAvatar (
      backgroundImage: AssetImage('img/logo.jpg'),
      radius:40,
      ), // CircleAvatar
    ), // CircleAvatar
    nextScreen: const MainRecipeScreen(),
    splashTransition: SplashTransition.rotationTransition,
    backgroundColor: Colors.black,); // AnimatedSplashScreen
  }
}