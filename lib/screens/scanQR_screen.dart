import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/scan.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ScanController controller = ScanController();
  String qrcode = 'Unknown';
  bool isStop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          controller.pause();
          return Future(() => true);
        },
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  controller.toggleTorchMode();
                },
                icon: const Icon(Icons.flash_on_rounded),
                label: const Text("Flash"),
              ),
              Text(qrcode.toString()),
              SizedBox(
                width: 250,
                height: 250,
                child: ScanView(
                  controller: controller,
                  scanAreaScale: .7,
                  scanLineColor: Colors.green.shade400,
                  onCapture: (str) async {
                    setState(() {
                      if (str.isNotEmpty) {
                        qrcode = str;
                        controller.pause();
                        isStop = true;
                      }
                    });
                  },
                ),
              ),
              if (isStop)
                IconButton(
                  onPressed: () {
                    controller.resume();
                    setState(() {
                      isStop = false;
                    });
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
