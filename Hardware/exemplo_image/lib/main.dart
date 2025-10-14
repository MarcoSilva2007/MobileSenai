import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ImagePickerScreen()));
}

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  //* vamos manipular imagens da galeria e imagens da camera ( arquivos )
  File? _image; //* manipula arquivos do Dispositivo
  //* cria uma classe de contrller para maniuplar a caemra e a galeria
  final _picker = ImagePicker();

  //? Métodos
  //* métood para tirar foto
  void _getImageFromCamera() async {
    //* abrir a camera e permitir tirar uma foto
    //* armazenar a foto em um arquivo temporario
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    //* verificar se o XFile não está vazio
    if (pickedFile != null) {
      setState(() {
        //*pega essa imagem temporaria e transfere para o file:io
        _image = File(pickedFile.path);
      });
    }
  }

  //* método para galeria
  void _getImageFromGallery() async {
    //* abrir a camera e permitir tirar uma foto
    //* armazenar a foto em um arquivo temporario
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    //* verificar se o XFile não está vazio
    if (pickedFile != null) {
      setState(() {
        //*pega essa imagem temporaria e transfere para o file:io
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* mostrar imagem selecionada pelo image picker
            _image != null
                ? Image.file(_image!, height: 300)
                : Text("Nenhuma Imagem Selecionada"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text("Tirar foto"),
            ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text("Escolher da Galeria"),
            ),
          ],
        ),
      ),
    );
  }
}
