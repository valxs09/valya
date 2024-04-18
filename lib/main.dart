import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Splash Screen Example',
      theme: ThemeData( 
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(),
      routes: {
        '/home': (_) => LottieAnimationScreen(),
      },
    );
  }
}
