import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valya/screens/autorizacion_screen.dart';

class LoginScreen2 extends StatefulWidget {
  @override
  _LoginScreenState2 createState() => _LoginScreenState2();
}

class _LoginScreenState2 extends State<LoginScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _conductorIdController = TextEditingController();
  final TextEditingController _camionIdController = TextEditingController();

  Future<void> _fetchDataAndNavigate(String conductorId, String camionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');

    final String apiUrl = 'https://api.valya.app/api/trips';

    try {
      final Map<String, dynamic> requestBody = {
        'id_vehicle': camionId,
        'id_responsible': conductorId,
      };

      final response = await http.get(
        Uri.parse('$apiUrl?id_vehicle=$camionId&id_responsible=$conductorId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Si la solicitud fue exitosa, procesa la respuesta JSON
        final jsonData = jsonDecode(response.body);
        // Filtrar los viajes que no estén finalizados
        final List<dynamic> trips = jsonData['data']['data'];
        print(response.body);
        // Intenta encontrar el primer viaje que no esté finalizado
        Map<String, dynamic> tripInProgress;
        try {
  tripInProgress = trips.firstWhere(
    (trip) => trip['status'] != 'Finalizado',
    orElse: () => null,
  );
    print('Viaje en progreso: $tripInProgress');

        } catch (e) {
          tripInProgress = {};
        }

        if (tripInProgress.isNotEmpty) {
          // Aquí puedes hacer lo que necesites con el viaje en progreso
          Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (_) => AutorizacionScreen(data: tripInProgress)),
          );
        } else {
          // Si no se encontró ningún viaje en progreso, inicializa tripInProgress como un mapa vacío
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Mensaje'),
                content: Text('No hay viajes en progreso para este conductor y camión.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Manejo de otros códigos de estado
        print('Error al cargar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      // Manejo de errores
      print('Error: $error');
    }
  }

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
              Image.asset(
                'assets/images/login.png',
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final String conductorId = _conductorIdController.text;
                          final String camionId = _camionIdController.text;
                          await _fetchDataAndNavigate(conductorId, camionId);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
