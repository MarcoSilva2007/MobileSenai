import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sa_somativa/services/location_service.dart';
import 'package:sa_somativa/services/auth_service.dart';
import 'package:sa_somativa/services/ponto_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    PontoService pontoService = PontoService();
    AuthService authService = AuthService();

    void _registrar(String tipo) async {
      try {
        await pontoService.registrarPonto(userId, tipo);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ponto de $tipo registrado!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem-vindo!'),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _registrar('entrada'),
              child: const Text('Registrar Entrada'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _registrar('saida'),
              child: const Text('Registrar Saída'),
            ),
          ],
        ),
      ),
    );
  }
}