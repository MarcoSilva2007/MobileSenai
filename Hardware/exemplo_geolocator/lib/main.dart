import 'package:exemplo_geolocator/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MaterialApp(home: LocationScreen()));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "Localização Não Encontrada";

  void _getLocation() async {
    //* Verificar se o serviço está abilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      locationMessage = "Serviço de Localização está Desativado";
      return;
    }
    //* Verifica a permissão do GPS
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //*Solicita a liberacao do uso do GPS
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage = "Permissão de Localização Negada";
        return;
      }
    }
    //* Se a posição foi liberada
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
  }

  void _getClima() async {
    //* Verificar se o serviço está abilitado
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      locationMessage = "Serviço de Localização está Desativado";
      return;
    }
    //* Verifica a permissão do GPS
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      //*Solicita a liberacao do uso do GPS
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationMessage = "Permissão de Localização Negada";
        return;
      }
    }
    //* Se a posição foi liberada
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //* Mostrar o clima
    try {
      final city = await ClimaService.getCityWeatherbyPosition(position);
      locationMessage = "${city["name"]} - ${city["main"]["temp"] - 273}°C";
    } catch (e) {
      locationMessage = e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(locationMessage),
            ElevatedButton(
              onPressed: () async {
                _getLocation();
                setState(() {});
              },
              child: Text("Obter Localização"),
            ),
            ElevatedButton(
              onPressed: () async {
                _getClima();
                setState(() {});
              },
              child: Text("Pegar o Clima"),
            ),
          ],
        ),
      ),
    );
  }
}
