// Meu serviço de conexão com API TMDB

import 'dart:convert';
import 'package:http/http.dart' as http;

class TmdbService {
  // Colocar os dados da API
  static const String _apiKey = "1fa5c2d59029fd1c438cc35713720604";
  static const String _baseUrl = "https://api.themoviedb.org/3";
  static const String _idioma = "pt-BR";
  //! IMPORTANTE: static -> atributos é da classe nao do OBJ
  //* Métodos static ou seja, método da classe (Não precisa instanciar OBJ para acessar o método)

  //* Buscar filme na API pelo termo
  static Future<List<Map<String, dynamic>>> searchMovie(String termo) async {
    //* Converter String em URL
    final apiURI = Uri.parse(
      "$_baseUrl/search/movie?api_key=$_apiKey&query=$termo&language=$_idioma",
    );
    //* http request -> get
    final response = await http.get(apiURI);

    //* verifico a resposta
    if (response.statusCode == 200) {
      //* converto a response de json para dart
      final data = json.decode(response.body);
      //* transformar data(string) em listMap
      return List<Map<String, dynamic>>.from(data["results"]);
    } else {
      //*caso contrário
      //* criar exception
      throw Exception("Falha ao carregar filmes da api");
    }
  }
}
