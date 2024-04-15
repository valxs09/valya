// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class TripApiService {
//   static Future<List<Trip>> getTrips(String conductorId, String camionId, String authToken) async {
//     final response = await http.get(
//       Uri.parse('https://api.valya.app/api/trips?vehicle_id=$camionId&responsible_id=$conductorId'),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> tripsJson = json.decode(response.body)['data'];
//       return tripsJson.map((json) => Trip.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load trips');
//     }
//   }
// }
