import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sa_somativa/models/location_points.dart';
import 'package:sa_somativa/services/location_service.dart';

class PontoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registrarPonto(String userId, String tipo) async {
    LocationService locationService = LocationService();
    bool dentro = await locationService.isDentroDoRaio();

    if (!dentro) {
      throw Exception('Você está fora do raio permitido (100m).');
    }

    Position pos = await locationService.getCurrentPosition();

    LocationPoints ponto = LocationPoints(
      userId: userId,
      dataHora: DateTime.now(),
      latitude: pos.latitude,
      longitude: pos.longitude,
      tipo: tipo, 
    );

    await _firestore.collection('registros').add(ponto.toMap());
  }
}