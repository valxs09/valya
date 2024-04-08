import 'package:flutter/material.dart';
import 'datos_iniciales.dart';
import 'package:lottie/lottie.dart';

class AutorizacionScreen extends StatefulWidget {
  const AutorizacionScreen({Key? key}) : super(key: key);

  @override
  _AutorizacionScreenState createState() => _AutorizacionScreenState();
}

class _AutorizacionScreenState extends State<AutorizacionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextScreen();
    });
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => FormDatosCamion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/done.json', // Ruta de tu archivo de animación
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 25),
            const Text(
              'Acceso autorizado',
              style: TextStyle(
                color: Color.fromARGB(255, 133, 0, 221),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
