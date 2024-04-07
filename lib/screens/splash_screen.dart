import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1550),
      vsync: this,
    );
    _animation = Tween<double>(begin: 3, end: 0).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Navegar a la pantalla principal después de la animación
          Navigator.of(context).pushReplacementNamed('/home');
        }
      });

    // Iniciar la animación al iniciar el estado
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade200, Color.fromARGB(255, 206, 157, 216)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset(
              'assets/images/logo.png',
              width: 500,
              height: 500,
            ),
          ),
        ),
      ),
    );
  }
}
