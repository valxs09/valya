import 'package:flutter/material.dart';

class DetallesScreen extends StatelessWidget {
  const DetallesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
        title: const Text(''),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(); // Regresar a la pantalla anterior
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/hombre.png'),
            ),
          ),
        ],
      ),
      body: Container(
        // Aquí iría el contenido de tu pantalla de detalles
      ),
    );
  }
}
