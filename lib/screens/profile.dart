import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valya/screens/edit_profile_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const ProfileDScreen());
}

class ProfileDScreen extends StatefulWidget {
  const ProfileDScreen({Key? key}) : super(key: key);

  @override
  _ProfileDScreenState createState() => _ProfileDScreenState();
}

class _ProfileDScreenState extends State<ProfileDScreen> {
  late Future<Map<String, dynamic>> _responsiblesData;

  @override
  void initState() {
    super.initState();
    _responsiblesData = _fetchResponsiblesData();
  }

  Future<Map<String, dynamic>> _fetchResponsiblesData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int idResponsible = prefs.getInt('id_responsible') ?? 0;
  String accessToken = prefs.getString('accessToken') ?? '';

  final url = 'https://api.valya.app/api/responsibles/$idResponsible';
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print('Error en la solicitud HTTP: ${response.statusCode}');
    print('Mensaje de error: ${response.body}');
    throw Exception('Failed to load responsibles data');
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 68, 33, 243),
          title: const Text(''),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Cambiar a Navigator.pop
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: _responsiblesData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final data = snapshot.data as Map<String, dynamic>;
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(data['image_link']),
                    ),
                    const SizedBox(height: 20),
                    itemProfile('Name', data['name'], CupertinoIcons.person),
                    const SizedBox(height: 10),
                    itemProfile('Phone', data['phone'], CupertinoIcons.phone),
                    const SizedBox(height: 10),
                    itemProfile('Address', data['address'], CupertinoIcons.location),
                    const SizedBox(height: 10),
                    itemProfile('License', data['license_number'], CupertinoIcons.doc_on_clipboard_fill),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileEditScreen(
          name: data['name'],
          phone: data['phone'],
          address: data['address'], // Pasa la dirección
          license: data['license_number'],
        ),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(15),
  ),
  child: const Text('Edit Profile')
),

                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Colors.deepOrange.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10
            )
          ]
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
        tileColor: Colors.white,
      ),
    );
  }
}
