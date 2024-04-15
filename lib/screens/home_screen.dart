import 'package:flutter/material.dart';
import 'login.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationScreen extends StatelessWidget {
  const LottieAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset(
                'assets/images/conductor.png', // Ruta de tu imagen
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 50),
            const Text(
              'Bienvenido conductor',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Escanee su camión',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginScreen()));
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
              child: const Text(
                  'Empezar!!!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}
