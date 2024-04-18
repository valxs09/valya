import 'package:flutter/material.dart';
import 'detalles_screen.dart';
import 'profile.dart'; // Importa tu pantalla de perfil
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TripItem extends StatefulWidget {
  const TripItem({
    Key? key,
    required this.tripData,
    required this.tripStarted,
    required this.tripEnded,
    required this.toggleTripStarted,
    required this.toggleTripEnded,
  }) : super(key: key);

  final Map<String, dynamic> tripData;
  final bool tripStarted;
  final bool tripEnded;
  final VoidCallback toggleTripStarted;
  final VoidCallback toggleTripEnded;

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.tripData['name'] ?? 'Unnamed Trip',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                if (!widget.tripStarted && !widget.tripEnded) {
                  widget.toggleTripStarted();
                } else if (widget.tripStarted && !widget.tripEnded) {
                  widget.toggleTripEnded();
                }
              },
              icon: Icon(
                widget.tripStarted
                    ? (widget.tripEnded
                        ? Icons.check_circle_outline
                        : Icons.pause_rounded)
                    : Icons.play_circle_outline,
                color: widget.tripStarted
                    ? (widget.tripEnded ? Colors.green : Colors.orange)
                    : Colors.purple,
                size: 40,
              ),
            ),
          ],
        ),
        subtitle: Visibility(
          visible: widget.tripStarted && !widget.tripEnded,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DetallesScreen(tripData: widget.tripData),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: const Color.fromARGB(
                      255, 113, 158, 220), // Color del botón 'Details'
                ),
                child: const Text('Details'),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.toggleTripEnded();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.red, // Color del botón 'End Trip'
                ),
                child: const Text('End Trip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TripList extends StatefulWidget {
  const TripList({Key? key, this.title, this.tripListJson}) : super(key: key);

  final String? title;
  final String? tripListJson;

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  late Future<List<Map<String, dynamic>>> _futurePoints;
  late String accessToken;
  List<bool> tripStartedStates =
      []; // Lista para almacenar los estados de los viajes

  @override
  void initState() {
    super.initState();
    _loadToken();
    _futurePoints = _initializeTripsList();
  }

  void _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      accessToken = prefs.getString('accessToken') ?? '';
      final int tripId = prefs.getInt('tripId') ?? 0;
      if (tripId != 0) {
        _futurePoints = _getPointsForTrip(tripId);
      }
    });
  }

  Future<List<Map<String, dynamic>>> _initializeTripsList() async {
    if (widget.tripListJson != null && widget.tripListJson!.isNotEmpty) {
      Map<String, dynamic>? jsonData = json.decode(widget.tripListJson!);

      if (jsonData != null && jsonData.containsKey('data')) {
        List<dynamic>? tripsData = jsonData['data'];

        if (tripsData != null && tripsData.isNotEmpty) {
          List<Map<String, dynamic>> tripsDataList =
              (tripsData).cast<Map<String, dynamic>>();
          tripStartedStates = List<bool>.filled(tripsDataList.length,
              false); // Inicializar tripStartedStates aquí

          // Iterar sobre la lista de datos de viaje y obtener los puntos para cada uno
          return Future.wait(
            tripsDataList
                .map((tripData) => _getPointsForTrip(tripData['id']))
                .toList(),
          ).then((List<List<Map<String, dynamic>>> pointsLists) {
            return pointsLists.expand((points) => points).toList();
          });
        }
      }
    }

    return [];
  }
Future<List<Map<String, dynamic>>> _getPointsForTrip(int idTrip) async {
  List<Map<String, dynamic>> pointsList = [];

  final Uri baseUrl = Uri.parse('https://api.valya.app/api/points');
  final Map<String, dynamic> queryParams = {'id_trip': idTrip.toString()};
  final Uri url = baseUrl.replace(queryParameters: queryParams);

  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    try {
      Map<String, dynamic> data = json.decode(response.body);

      print('Response data: $data'); // Imprimir la respuesta JSON completa

      if (data.containsKey('data') && data['data']['data']is List) {
        List<dynamic> pointsData = data['data']['data'];

        pointsList.addAll(pointsData
            .map((point) => point as Map<String, dynamic>)
            .toList());
      } else {
        throw Exception('Invalid data format in API response for trip $idTrip');
      }
    } on FormatException catch (e) {
      print('Error parsing JSON response: $e');
      throw Exception('Failed to parse API response for trip $idTrip');
    } catch (e) {
      print('Unexpected error fetching points for trip $idTrip: $e');
      rethrow;
    }
  } else {
    throw Exception(
        'Failed to load points for trip $idTrip. Status code: ${response.statusCode}');
  }

  return pointsList;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
        title: const Text(''),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileDScreen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/hombre.png'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Viajes del día',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _futurePoints,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> pointsList = snapshot.data ?? [];

                  if (pointsList.isEmpty) {
                    return Center(child: Text('No points found in the list.'));
                  } else {
                    // Inicializar tripStartedStates con la misma longitud que pointsList
                    tripStartedStates =
                        List<bool>.filled(pointsList.length, false);

                    return ListView.builder(
                      itemCount: pointsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(
          vertical: 16, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: const Color.fromARGB(
          255, 8, 23, 156), // Color del botón
    ),
    child: Text(
      (pointsList[index]['trip'] != null && pointsList[index]['trip']['name'] != null)
          ? pointsList[index]['trip']['name']
          : 'Unnamed Trip',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white, // Color blanco para el texto
      ),
    ),
  ),
),

                            TripItem(
                              tripStarted: tripStartedStates[index],
                              tripEnded:
                                  false, // No estoy seguro de cómo determinar tripEnded
                              toggleTripStarted: () => toggleTripStarted(index),
                              toggleTripEnded: () => toggleTripEnded(index),
                              tripData: pointsList[index],
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Método para cambiar el estado de inicio del viaje
  void toggleTripStarted(int index) {
    setState(() {
      tripStartedStates[index] = !tripStartedStates[index];
    });
  }

  // Método para cambiar el estado de finalización del viaje
  void toggleTripEnded(int index) {
    // Código para cambiar el estado de finalización del viaje
  }
}
