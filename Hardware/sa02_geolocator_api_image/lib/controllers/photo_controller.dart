import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sa02_geolocator_api_image/models/photo_model.dart';

class PhotoController {
  //TODO pegar geolocalização, busca api para transformar lat e lon em localização, tirar a photo, retornar o obj
  //* controllador para camera
  final _picker = ImagePicker();
  File? _file;
  String? location;

  //* método future ( retornara um obj de photoModel )
  Future<PhotoModel> getImagemWithLocation() async {
    //* verifica se a geolocalização esta habilitada
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Serviço desabilitado");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Continua não Permitida");
      }
    }
    //* foi liberada pelo usuario
    Position position = await Geolocator.getCurrentPosition();
    //* chamar a api e buscar o nome da localização
    final result = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?appid=CHAVE_API&lat=${position.latitude}&lon=${position.longitude}",
      ),
    );
    if (result.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(result.body);
      location = data["name"].toString();
    }
    //* tirar foto
    final XFile? fotoTirada = await _picker.pickImage(
      source: ImageSource.camera,
    );
    //* verifico se a foto foi tirada
    if (fotoTirada != null) {
      _file = File(fotoTirada.path);
    } else {
      throw Exception("Foto não tirada");
    }

    //* criar obj do PhotoModel
    final photo = PhotoModel(
      location: location!,
      photoPath: _file!,
      timeStamp: DateTime.now().toIso8601String(),
    );
    return photo;
  }
}
