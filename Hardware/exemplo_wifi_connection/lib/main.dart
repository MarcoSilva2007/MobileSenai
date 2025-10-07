import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: WifiStatusScreen()));
}

class WifiStatusScreen extends StatefulWidget {
  const WifiStatusScreen({super.key});

  @override
  State<WifiStatusScreen> createState() => _WifiStatusScreenState();
}

class _WifiStatusScreenState extends State<WifiStatusScreen> {
  //* atributos
  String _mensagem = "";
  //* Lista que ira armazenar as mudanças de status
  late StreamSubscription<List<ConnectivityResult>> _conexao;

  //* Métodos
  //* Método para verificar a conexão no começo da aplicação
  void _checkInitialConnection() async {
    ConnectivityResult result =
        (await Connectivity().checkConnectivity()) as ConnectivityResult;
    _updateConnection(result);
  }

  //* Método que vai identificar as mudanças de conexão
  void _updateConnection(ConnectivityResult result) async {
    setState(() {
      switch (result) {
        case ConnectivityResult.wifi:
          _mensagem = "Conectado pelo Wifi";
          break;
        case ConnectivityResult.mobile:
          _mensagem = "Conectado pelos Dados Móveis";
          break;
        case ConnectivityResult.none:
          _mensagem = "Sem Conexão com a Internet";
          break;
        default:
          _mensagem = "Procurando Conexão";
      }
    });
  }

  //* Vai rodar no começo
  @override
  void initState() {
    super.initState();
    //* 1. Faz a verificação inicial
    _checkInitialConnection();
    //* 2. Começa a ouvir a Mudanças de Status (Listener) -> Stream
    _conexao = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final result = results.isNotEmpty
          ? results.first
          : ConnectivityResult.none;
      _updateConnection(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Status da Conexão")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Vai mudar de acordo com a conexão
            Icon(
              _mensagem.contains("WIFI")
                  ? Icons.wifi
                  : _mensagem.contains("Dados")
                  ? Icons.network_cell
                  : Icons.wifi_off,
              size: 80,
              color: _mensagem.contains("Sem Conexão")
                  ? Colors.red
                  : Colors.blue,
            ),
            SizedBox(height: 10),
            Text("Status: $_mensagem"),
          ],
        ),
      ),
    );
  }
}
