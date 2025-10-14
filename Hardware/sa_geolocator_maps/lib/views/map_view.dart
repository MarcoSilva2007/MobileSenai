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
  List<LocationPoints> listarPontos =
      []; //* Lista coms os pontos marcados no map
  final _pointController =
      PointController(); //* obj de controller da classe pointController
  final MapController _flutterMapController =
      MapController(); //* obj de controller para manipulacao do mapa ( criado pela biblioteca )

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
      //* deslocar o mapa para o ponto marcado
      _flutterMapController.move(
        LatLng(novaMarcacao.latitude, novaMarcacao.longitude),
        11,
      );
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
          initialCenter: LatLng(-22.3352, -47.2406),
          initialZoom: 13,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.sa_geolocator.maps",
          ),
          //* camada de marcações
          MarkerLayer(
            markers: listarPontos
                .map(
                  (ponto) => Marker(
                    point: LatLng(ponto.latitude, ponto.longitude),
                    width: 50,
                    height: 50,
                    child: Icon(Icons.location_on, color: Colors.red, size: 35),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
