import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_shared_preferences/tela_inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(home: ConfigPage()));
}

class ConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConfigPageState();
  }
}

class _ConfigPageState extends State<ConfigPage> {
  // atributos
  bool temaEscuro = false;
  String nomeUsuario = "";

  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  void carregarPreferencias() async {
    final prefs =
        await SharedPreferences.getInstance(); // Conexão com o shared prefs
    String? jsonString = prefs.getString(
      "config",
    ); // Recebendo os valores referentes a chave "config" do SP
    if (jsonString != null) {
      // Veifica se o jsonString esta vazio
      Map<String, dynamic> config = json.decode(jsonString);
      setState(() {
        //  Método para a mudança de estado
        temaEscuro = config["temaEscuro"] ?? false;
        nomeUsuario = config["nome"] ?? "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Configuração",
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: TelaInicial(temaEscuro: temaEscuro, nomeUsuario: nomeUsuario,),
    );
  }
}
