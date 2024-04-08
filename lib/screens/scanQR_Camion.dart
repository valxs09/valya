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
  bool isFlashOn = false; // Variable para controlar el estado del flash

  // Método para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _scanImage(pickedFile.path);
    }
  }

  // Método para escanear una imagen
  Future<void> _scanImage(String imagePath) async {
    String? result = await Scan.parse(imagePath);
    setState(() {
      if (result != null && result.isNotEmpty) {
        qrcode = result;
        controller.pause();
        isStop = true;
      } else {
        qrcode = 'Unknown';
      }
    });
  }

  // Método para alternar el estado del flash
  void _toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    controller.toggleTorchMode(); // Alternar el estado del flash
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          controller.pause();
          return Future(() => true);
        },
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Escanear Código QR del camión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  height: 250,
                  child: ScanView(
                    controller: controller,
                    scanAreaScale: .7,
                    scanLineColor: Colors.green.shade400,
                    onCapture: (str) async {
                      _scanImage(str); // Escanear la imagen capturada
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(qrcode.toString()),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: _toggleFlash, // Habilitar/deshabilitar el flash
                      icon: Icon(
                        isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                        size: 40,
                        color: Colors.purple, // Color morado
                      ),
                    ),
                    IconButton(
                      onPressed: _pickImage, // Invocar el selector de imágenes
                      icon: Icon(
                        Icons.image_rounded,
                        size: 40,
                        color: Colors.purple, // Color morado
                      ),
                    ),
                  ],
                ),
             
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (isStop) {
                        controller.resume(); // Reiniciar el escaneo si está en pausa
                        isStop = false;
                      } else {
                        controller.pause(); // Pausar el escaneo si está en curso
                        isStop = true;
                      }
                    });
                  },
                  icon: Icon(
                    isStop ? Icons.play_arrow_rounded : Icons.pause_rounded,
                    size: 40,
                    color: Colors.purple, // Color morado
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
