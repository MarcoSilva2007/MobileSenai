//* formatador de data e hora

import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class PointController {
  final DateFormat _formatar = DateFormat("dd/MM/yyyy - HH:mm:ss");

  //* Solicitar a localização do dispositivo
  //* Método para pegar a localização
  Future<LocationPoints> getCurrentLocation() async {
    //* Verificar se as permissões estão liberadas
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      throw Exception("Sem Acesso ao GPS");
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Permissão Negada ao Acesso ao GPS");
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    String dataHora = _formatar.format(DateTime.now());
    //* criar um obj de Model
    LocationPoints posicaoAtual = LocationPoints(
      latitude: position.latitude,
      longitude: position.longitude,
      dataHora: dataHora,
    );
    return posicaoAtual;
  }
}
