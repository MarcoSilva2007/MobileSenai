import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sa_geolocator_maps/controllers/point_controller.dart';
import 'package:sa_geolocator_maps/models/location_points.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //*Atributos
  List<LocationPoints> listarPontos = [];
  final _pointController = PointController();
  final MapController _flutterMapController = MapController();

  bool _isLoading = false;
  String? _erro;

  //*método para adicionar o ponto no mapa
  void _adicionarPonto() async {
    setState(() {
      _isLoading = true;
      _erro = null;
    });
    try {
      //* pega a localizacao atual
      LocationPoints novaMarcacao = await _pointController.getCurrentLocation();
      listarPontos.add(novaMarcacao);
    } catch (e) {
      _erro = e.toString();
      //* Mostro o erro
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Adicionar pontos no mapa
      //* Adicionar a biblioteca flutter_Map(flutter_map)
      appBar: AppBar(
        title: Text("Mapa de Localização"),
        actions: [
          IconButton(
            onPressed: _isLoading
                ? null
                : _adicionarPonto, //* Evita de o botao ser pressionado seguidamente
            icon: _isLoading
                ? Padding(
                    padding: EdgeInsets.all(8),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Icon(Icons.add_location_alt),
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _flutterMapController,
        options: MapOptions(
          initialCenter: LatLng(-23.561684, -46.625378),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://title.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.sa_locator.maps",
          ),
        ],
      ),
    );
  }
}
