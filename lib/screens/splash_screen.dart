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
      debugShowCheckedModeBanner: false, // Ocultar la etiqueta de depuración
      home: Scaffold(
        backgroundColor: Colors.transparent, // Hace que el fondo del Scaffold sea transparente
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 220, 0, 180), // #DC00B2
                Color.fromARGB(255, 216, 0, 224), // #CA00D0
                Color.fromARGB(255, 191, 0, 212), // #BE00D4
                Color(0xFFA821DD), // #A821DD
                Color(0xFF9138EA), // #9138EA
              ],
              stops: [0.0, 0.25, 0.5, 0.75, 1.0], // Porcentajes de parada para cada color
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
      ),
    );
  }
}
