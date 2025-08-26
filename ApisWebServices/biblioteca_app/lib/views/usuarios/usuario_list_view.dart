import 'package:biblioteca_app/controllers/usuario_controller.dart';
import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:flutter/material.dart';

class UsuarioListView extends StatefulWidget {
  const UsuarioListView({super.key});

  @override
  State<UsuarioListView> createState() => _UsuarioListViewState();
}

class _UsuarioListViewState extends State<UsuarioListView> {
  // Atributos
  final _controller = UsuarioController();
  List<UsuarioModel> _usuarios = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _usuarios = await _controller.pegueTodos();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _carregando
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _usuarios.length,
              itemBuilder: (context, index) {
                final usuario = _usuarios[index];
                return Card(
                  child: ListTile(
                    title: Text(usuario.nome),
                    subtitle: Text(usuario.email),
                  ),
                );
              },
            ),
    );
  }
}
