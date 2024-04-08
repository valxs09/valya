import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FormDatosCamion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
        title: const Text(''),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/hombre.png'),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Datos del Camión',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 68, 33, 243),
                ),
              ),
              const SizedBox(height: 25),
              const Row(
                children: [
                  Text(
                    'Kilometraje inicial:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese el kilometraje inicial',
                ),
              ),
              const SizedBox(height: 16.0),
              const Row(
                children: [
                  Text(
                    'Combustible inicial:',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ingrese la gasolina inicial',
                ),
              ),
              const SizedBox(height: 16.0),
              Lottie.asset(
                'assets/images/transport.json',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Aquí iría la lógica para procesar los datos del formulario
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 68, 33, 243),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Continuar',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
