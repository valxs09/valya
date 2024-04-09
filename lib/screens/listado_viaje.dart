import 'package:flutter/material.dart';
import 'detalles_screen.dart';

class ViajeItem extends StatefulWidget {
  const ViajeItem({Key? key, required this.location, required this.toggleViajeIniciado, required this.toggleViajeFinalizado}) : super(key: key);

  final String location;
  final VoidCallback toggleViajeIniciado;
  final VoidCallback toggleViajeFinalizado;

  @override
  _ViajeItemState createState() => _ViajeItemState();
}

class _ViajeItemState extends State<ViajeItem> {
  bool viajeIniciado = false;
  bool viajeFinalizado = false;

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
              'Chapur ${widget.location}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  viajeIniciado = !viajeIniciado;
                  widget.toggleViajeIniciado();
                });
              },
              icon: Icon(
                viajeIniciado ? (viajeFinalizado ? Icons.check_circle_outline : Icons.pause_rounded) : Icons.play_circle_outline,
                color: viajeIniciado ? (viajeFinalizado ? Colors.green : Colors.orange) : Colors.purple,
                size: 40,
              ),
            ),
          ],
        ),
        subtitle: Visibility(
          visible: viajeIniciado && !viajeFinalizado,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            ElevatedButton(
  onPressed: () {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const DetallesScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    backgroundColor: const Color.fromARGB(255, 113, 158, 220), // Color del botón 'Detalles'
  ),
  child: const Text('Detalles'),
),

              ElevatedButton(
                onPressed: () {
                  // Lógica para finalizar el viaje
                  setState(() {
                    viajeFinalizado = true;
                    widget.toggleViajeFinalizado(); // Llamar al método para indicar que el viaje ha sido finalizado
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  backgroundColor: Colors.red, // Color del botón 'Finalizar'
                ),
                child: const Text('Finalizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ListadoViajes extends StatefulWidget {
  const ListadoViajes({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListadoViajesState createState() => _ListadoViajesState();
}

class _ListadoViajesState extends State<ListadoViajes> {
  bool viajeIniciado = false;
  List<bool> viajesFinalizados = [false, false, false, false]; // Lista para rastrear si cada viaje está finalizado

  @override
  Widget build(BuildContext context) {
    // Verificar si todos los viajes están finalizados
    bool todosFinalizados = viajesFinalizados.every((finalizado) => finalizado);

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
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: const Color.fromARGB(255, 8, 23, 156), // Color del botón
              ),
              child: const Text(
                'Chapur-Matutiono-0504',
                style: TextStyle(fontSize: 19),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return ViajeItem(
                  location: getLocationName(index),
                  toggleViajeIniciado: () {
                    setState(() {
                      viajeIniciado = !viajeIniciado;
                    });
                  },
                  // Actualizar el estado de finalización del viaje
                  toggleViajeFinalizado: () {
                    setState(() {
                      viajesFinalizados[index] = !viajesFinalizados[index];
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Botón "Finalizar Viajes"
          Visibility(
            visible: todosFinalizados,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción cuando se presiona el botón "Finalizar Viajes"
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Color.fromARGB(255, 112, 96, 228), // Color del botón
                ),
                child: const Text(
                  'Finalizar Viajes',
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getLocationName(int index) {
    switch (index) {
      case 0:
        return 'Centro';
      case 1:
        return 'del Norte';
      case 2:
        return 'Harbor';
      case 3:
        return 'Sur';
      default:
        return '';
    }
  }
}

