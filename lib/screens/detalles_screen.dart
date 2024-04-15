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
            Navigator.pop(context); // Utiliza Navigator.pop en lugar de Navigator.pushReplacement
          },
          icon: const Icon(Icons.arrow_back),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Detalles destino 1',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ), // Título de la pantalla en el cuerpo
          _buildDetailText('Lugar de destino:', 'Nombre del lugar'), // Detalle de lugar de destino
          _buildDetailText('Dirección:', 'Dirección del lugar'), // Detalle de dirección
          _buildDetailText('Estado del viaje:', 'Estado actual'), // Detalle de estado del viaje
        ],
      ),
    );
  }

  Widget _buildDetailText(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
