import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaController {
  final String _apiKey = 'a845b4a4d3eddee5c3451a24b75938e5';

  // Método para pegar a informação de um clima de uma cidade
  Future<ClimaModel?> buscarClima(String cidade) async {
    final url = Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&unit=metric&lang=pt_br",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      return ClimaModel.fromJson(dados);
    } else {
      return null;
    }
  }
}
