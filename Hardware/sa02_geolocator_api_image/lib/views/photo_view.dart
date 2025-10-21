import 'package:flutter/material.dart';
import 'package:sa02_geolocator_api_image/models/photo_model.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<PhotoModel> photos = [];

  void takePicture() async {
    //* não por o método para tirar a photo do controller
    setState(() {
      //*adicionar a foto na lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //*abre a foto quando clicada com as informações
            },
            child: Image.file(photos[index].photoPath),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: takePicture),
    );
  }
}
