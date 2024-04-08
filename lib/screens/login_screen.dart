import 'package:flutter/material.dart';
import 'scanQR_Camion.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/welcome.json', // Ruta de tu archivo de animación
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido conductor escanee su camión',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const ScanScreen()));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 68, 33, 243), // Color del texto del botón
                padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 50), // Espaciado interno del botón
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Bordes redondeados del botón
                ),
                textStyle: const TextStyle(
                  fontSize: 18, // Tamaño del texto del botón
                ),
              ),
              child: const Text('Empezar!!!'), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}
