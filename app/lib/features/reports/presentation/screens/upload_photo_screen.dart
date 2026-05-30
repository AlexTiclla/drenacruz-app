import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() => _image = photo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subir foto')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) const Text('Foto capturada'),
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text('Tomar foto con cámara'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/citizen/report/analysis'),
              child: const Text('Analizar con IA'),
            ),
          ],
        ),
      ),
    );
  }
}
