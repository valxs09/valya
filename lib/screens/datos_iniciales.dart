import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'listado_viaje.dart';

class FormDatosCamion extends StatefulWidget {
  @override
  _FormDatosCamionState createState() => _FormDatosCamionState();
}

class _FormDatosCamionState extends State<FormDatosCamion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _kilometrajeController = TextEditingController();
  TextEditingController _combustibleController = TextEditingController();
  bool _validateKilometraje = false;
  bool _validateCombustible = false;

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
          child: Form(
            key: _formKey,
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
                  controller: _kilometrajeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese el kilometraje inicial',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        _validateKilometraje = true;
                      });
                      return 'Ingrese el kilometraje inicial';
                    }
                    return null;
                  },
                ),
                _validateKilometraje
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(
                          'Ingrese el kilometraje inicial',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container(),
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
                  controller: _combustibleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la gasolina inicial',
                    errorStyle: TextStyle(color: Colors.red),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      setState(() {
                        _validateCombustible = true;
                      });
                      return 'Ingrese la gasolina inicial';
                    }
                    return null;
                  },
                ),
                _validateCombustible
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(
                          'Ingrese la gasolina inicial',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 10),
                Lottie.asset(
                  'assets/images/transporte.json',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const ListadoViajes(title: '',)),
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
                    'Continuar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ), // Texto del botón
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
