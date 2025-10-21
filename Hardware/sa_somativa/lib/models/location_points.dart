import 'package:cloud_firestore/cloud_firestore.dart';

class LocationPoints {
  final String? id;
  final String userId;
  final double latitude;
  final double longitude;
  final DateTime dataHora;
  final String tipo;

  LocationPoints({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.dataHora,
    required this.userId,
    required this.tipo,
  });
  //* Atributos
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'latitude': latitude,
    'longitude': longitude,
    'dataHora': dataHora,
    'tipo': tipo,
  };

  static LocationPoints fromJson(Map<String, dynamic> json) => LocationPoints(  
        userId: json['userId'],
        dataHora: (json['dataHora'] as Timestamp).toDate(),
        latitude: json['latitude'],
        longitude: json['longitude'],
        tipo: json['tipo'], 
      );
}
