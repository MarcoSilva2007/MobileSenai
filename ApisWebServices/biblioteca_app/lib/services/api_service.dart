// CLasse de auxilio nas chamadas da API

import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  // Atributos e Métodos da classe não do OBJ
  // BaseUrl para conexão api
  // Static -> transoforma o atributo em atributo da classe e não do OBJ
  static const String _baseUrl = "http://10.109.197.37:3001";

  // Métodos
  // GET (Listar todos os recursos)
  static Future<List<dynamic>> getList(String path) async {
    final res = await http.get(
      Uri.parse(
        // Converte String -> URL
        "$_baseUrl/$path",
      ),
    );
    if (res.statusCode == 200) {
      return json.decode(
        res.body,
      ); // deu certo convert as respostas de json -> list dynamic e final
    }
    // se não deu certo -> gerar um erro
    throw Exception("Falha ao Carregar Lista de $path");
  }

  // GET (Listar um unico recurso)
  static Future<Map<String, dynamic>> getOne(String path, String id) async {
    final res = await http.get(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode == 200) return json.decode(res.body);
    // se não deu certo -> cria erro
    throw Exception("Falha ao Carregar Recurso de $path");
  }

  // POST (Criar novo recurso)
  static Future<Map<String,dynamic>> post(String path, Map<String,dynamic> body) async{
    final res = await http.post(
      //endereço da api
      Uri.parse("$_baseUrl/$path"),
      //headers
      headers: {"Content-Type":"application/json"},
      body: json.encode(body)
    );
    if(res.statusCode == 201) return json.decode(res.body);
    // se não deu certo
    throw Exception("Falha ao Criar Recurso em $path");
  }

  // PUT (Atualizar Recurso)
  static Future<Map<String,dynamic>> put(String path, Map<String,dynamic> body, String id) async{
    final res = await http.put(
      //endereço da api
      Uri.parse("$_baseUrl/$path/$id"),
      //headers
      headers: {"Content-Type":"application/json"},
      body: json.encode(body)
    );
    if(res.statusCode == 200) return json.decode(res.body);
    // se não deu certo
    throw Exception("Falha ao Criar Recurso em $path");
  }

  // DELETE (Apagar Recurso)
  static delete(String path, String id) async {
    final res = await http.delete(Uri.parse("$_baseUrl/$path/$id"));
    if (res.statusCode != 200) throw Exception("Falha ao Deletar Recurso $path");
  }
}
