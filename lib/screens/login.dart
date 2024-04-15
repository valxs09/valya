import 'package:flutter/material.dart';
import 'autorizacion_screen.dart';
import 'listado_viaje.dart';
import 'package:valya/data/models/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _conductorIdController = TextEditingController();
  final TextEditingController _camionIdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
        title: const Text(''),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            
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
                'Inicio de Sesión',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 68, 33, 243),
                ),
              ),
              const SizedBox(height: 25),
              // Aquí puedes agregar la animación
             Image.asset(
                'assets/images/login.png', // Ruta de tu imagen
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _conductorIdController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ID del Conductor',
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el ID del Conductor';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _camionIdController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ID del Camión',
                        errorStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el ID del Camión';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const AutorizacionScreen()),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(
                            255, 68, 33, 243), // Color del texto del botón
                        padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 50), // Espaciado interno del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Bordes redondeados del botón
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18, // Tamaño del texto del botón
                        ),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ), // Texto del botón
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
