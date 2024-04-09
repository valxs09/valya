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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(103, 212, 211, 211), // Hacer el fondo transparente
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFFF82BD7)
                    .withOpacity(0.8), // Color inicial con opacidad reducida
                const Color(0xFF6B61E2)
                    .withOpacity(0.4), // Color final con opacidad reducida
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/images/logo.png',
                width: 700,
                height: 700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
