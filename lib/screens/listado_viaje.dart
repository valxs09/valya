import 'package:flutter/material.dart';
import 'detalles_screen.dart';
import 'profile.dart'; // Importa tu pantalla de perfil
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TripItem extends StatefulWidget {
  const TripItem({
    Key? key,
    required this.tripData,
    required this.toggleTripStarted,
    required this.toggleTripEnded,
  }) : super(key: key);

  final Map<String, dynamic> tripData;
  final VoidCallback toggleTripStarted;
  final VoidCallback toggleTripEnded;

  @override
  _TripItemState createState() => _TripItemState();
}

class _TripItemState extends State<TripItem> {
  bool tripStarted = false;
  bool tripEnded = false;

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
                if (!tripStarted && !tripEnded) {
                  _startTrip();
                } else if (tripStarted && !tripEnded) {
                  _endTrip();
                }
              },
              icon: Icon(
                tripStarted
                    ? (tripEnded
                        ? Icons.check_circle_outline
                        : Icons.pause_rounded)
                    : Icons.play_circle_outline,
                color: tripStarted
                    ? (tripEnded ? Colors.green : Colors.orange)
                    : Colors.purple,
                size: 40,
              ),
            ),
          ],
        ),
        subtitle: Visibility(
          visible: tripStarted && !tripEnded,
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
                  _endTrip();
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

  void _startTrip() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int idVehicle = widget.tripData['id_vehicle'] ?? 0;
    int idResponsible = widget.tripData['id_responsible'] ?? 0;
    if (idVehicle != 0 && idResponsible != 0) {
      setState(() {
        tripStarted = true;
        widget.toggleTripStarted(); // Llamar al método para indicar que el viaje ha sido iniciado
      });
    } else {
      // Manejar la situación en la que no se encuentran los datos del vehículo o del responsable
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please set vehicle and responsible ID first.'),
      ));
    }
  }

  void _endTrip() {
    // Lógica para finalizar el viaje
    setState(() {
      tripEnded = true;
      widget.toggleTripEnded(); // Llamar al método para indicar que el viaje ha sido finalizado
    });
  }
}

class TripList extends StatefulWidget {
  const TripList({Key? key,  this.title, this.tripListJson}) : super(key: key);

  final String? title;
  final String? tripListJson; 

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  bool tripStarted = false;
  List<bool> tripsEnded = [];

  @override
  void initState() {
    super.initState();
    _initializeTripsList();
  }

void _initializeTripsList() {
  Map<String, dynamic> jsonData = jsonDecode(widget.tripListJson!);
  List<dynamic> tripsData = jsonData['data']['data'];
  tripsEnded = List<bool>.filled(tripsData.length, false);
}


  @override
  Widget build(BuildContext context) {
    // Check if all trips have ended
    bool allEnded = tripsEnded.every((ended) => ended);

    Map<String, dynamic> jsonData = jsonDecode(widget.tripListJson.toString());
    List<dynamic> tripsData = jsonData['data']['data'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 68, 33, 243),
        title: const Text(''),
        actions: [
          Row(
            children: [
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
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Today\'s Trips',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: tripsData.length,
              itemBuilder: (context, index) {
                return TripItem(
                  tripData: tripsData[index],
                  toggleTripStarted: () {
                    setState(() {
                      tripStarted = !tripStarted;
                    });
                  },
                  // Update the trip end state
                  toggleTripEnded: () {
                    setState(() {
                      tripsEnded[index] = !tripsEnded[index];
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // "End Trips" Button
          Visibility(
            visible: allEnded,
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 40), // Bottom margin to move the button up
                child: ElevatedButton(
                  onPressed: () {
                    // Action when "End Trips" button is pressed
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(255, 112, 96, 228), // Button color
                  ),
                  child: const Text(
                    'End Trips',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
