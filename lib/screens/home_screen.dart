import 'package:flutter/material.dart';
import 'scanQR_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String qrcode = 'Unknown';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              children: [
                ElevatedButton(
                  child: const Text("parse from image"),
                  onPressed: () {
                    // Add logic to parse image
                  },
                ),
                ElevatedButton(
                  child: const Text('go scan page'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ScanScreen()));
                  },
                ),
              ],
            ),
            Text('scan result is $qrcode'),
          ],
        ),
      ),
    );
  }
}