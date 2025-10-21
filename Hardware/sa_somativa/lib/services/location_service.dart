import 'package:geolocator/geolocator.dart';

class LocationService {
  static const double LAT_TRABALHO = -23.550524;
  static const double LNG_TRABALHO = -46.633309;
  static const int RAIO_MAX_METROS = 100;

  Future<bool> isDentroDoRaio() async {
    try {
      // Verifica se o GPS está ligado
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // Pede permissão se necessário
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      // Se ainda estiver negado ou "nunca perguntar de novo", falha
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        return false;
      }

      // Só aceita se tiver permissão ativa
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return false;
      }

      // Pega localização e calcula distância
      Position position = await Geolocator.getCurrentPosition();
      double distancia = Geolocator.distanceBetween(
        LAT_TRABALHO,
        LNG_TRABALHO,
        position.latitude,
        position.longitude,
      );

      return distancia <= RAIO_MAX_METROS;
    } catch (e) {
      print('Erro na localização: $e');
      return false;
    }
  }
  
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition();
  }
}

