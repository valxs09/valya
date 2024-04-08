import 'package:flutter/material.dart';
import 'scanQR_Camion.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Container(
                alignment: Alignment.center,
                width: 400,
                height: 400,
                child: Lottie.asset(
                  'assets/images/animacion.json', // Ruta de tu archivo de animación
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 0),
            const Text(
              'Escaneado correctamente',
              style: TextStyle(
                color: Color.fromARGB(255, 60, 193, 64),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ahora escanee al encargado',
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
                  MaterialPageRoute(builder: (_) => const ScanScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 68, 33, 243), // Color del botón
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 50,
                ), // Espaciado interno del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados del botón
                ),
                textStyle: const TextStyle(
                  fontSize: 18, // Tamaño del texto del botón
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Continuar',
              ), // Texto del botón
            ),
          ],
        ),
      ),
    );
  }
}
