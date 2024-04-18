import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:valya/screens/listado_viaje.dart';

class FormDatosCamion extends StatefulWidget {
  final Map<String, dynamic> data; // Definir el parámetro data

  const FormDatosCamion({Key? key, required this.data}) : super(key: key);

  @override
  _FormDatosCamionState createState() => _FormDatosCamionState();
}

class _FormDatosCamionState extends State<FormDatosCamion> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _kilometrajeController = TextEditingController();
  final TextEditingController _combustibleController = TextEditingController();
  bool _validateKilometraje = false;
  bool _validateCombustible = false;

  String? accessToken; // Variable para almacenar el accessToken

  @override
  void initState() {
    super.initState();
    _loadToken(); // Cargar el token cuando se inicializa el widget
    // Inicializar los controladores con los valores proporcionados en los datos del viaje
    _kilometrajeController.text = widget.data['initial_mileage'];
    _combustibleController.text = widget.data['initial_fuel'];
  }

  // Método para cargar el token de SharedPreferences
  void _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('accessToken');
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Construir el cuerpo de la solicitud
      final Map<String, dynamic> formData = {
        'id': widget.data['id'],
        'id_facility': widget.data['id_facility'],
        'id_vehicle': widget.data['id_vehicle'],
        'id_responsible': widget.data['id_responsible'],
        'name': widget.data['name'],
        'date': widget.data['date'],
        'initial_mileage': _kilometrajeController.text,
        'initial_fuel': _combustibleController.text,
        'status': widget.data['status'],
        'final_mileage': widget.data['final_mileage'],
        'final_fuel': widget.data['final_fuel'],
        'created_at': widget.data['created_at'],
        'updated_at': widget.data['updated_at'],
      };

      // Convertir el mapa a una cadena JSON
      String requestBody = json.encode(formData);

      // Realizar la solicitud PUT
      final response = await http.put(
        Uri.parse('https://api.valya.app/api/trips/${widget.data['id']}'),
        body: requestBody, // Pasar la cadena JSON como cuerpo de la solicitud
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken', // Incluir el token en los encabezados
        },
      );

      if (response.statusCode == 200) {
        // Si la solicitud es exitosa, navegar a la pantalla TripList
        Navigator.push(
          context,
          MaterialPageRoute(       builder: (context) => TripList(title: '', tripListJson: json.encode(widget.data)),
 // Pasar los datos de tripInProgress aquí)),
        ));
      } else {
        // Si la solicitud falla, mostrar un mensaje de error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Hubo un error al enviar los datos. Por favor, inténtalo de nuevo.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos del Camión'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Kilometraje inicial:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _kilometrajeController,
                decoration: InputDecoration(
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
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Combustible inicial:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _combustibleController,
                decoration: InputDecoration(
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
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Text(
                        '',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : Container(),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 68, 33, 243),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
