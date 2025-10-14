import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ImageGridView()));
}

class ImageGridView extends StatefulWidget {
  const ImageGridView({super.key});

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  //* Manipulação de Imagens
  File? _image;
  //* Classe controller gerada automaticamente
  final _selecionado = ImagePicker();

  //? Métodos
  //* pegando imagem da camera
  void _getImagemFromCamera() async {
    final XFile? imagemSelecionada = await _selecionado.pickImage(
      source: ImageSource.camera,
    );
  }

  //* pegando imagem da galeria
  void _getImagemFromGallery() async {
    final XFile? imagemSelecionada = await _selecionado.pickImage(
      source: ImageSource.gallery,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid de Imagens")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              padding: const EdgeInsets.all(20),
              primary: false,
            ),
          ],
        ),
      ),
    );
  }
}
