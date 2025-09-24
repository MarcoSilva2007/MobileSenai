import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TarefasView extends StatefulWidget {
  const TarefasView({super.key});

  @override
  State<TarefasView> createState() => _TarefasViewState();
}

class _TarefasViewState extends State<TarefasView> {
  //Atributos
  final FirebaseFirestore _db =
      FirebaseFirestore.instance; // Controlador do Cloud_Store
  final User? _user =
      FirebaseAuth.instance.currentUser; //Pega a info do user conectado
  final TextEditingController _tarefaField = TextEditingController();

  //Adicionar tarefa
  void _addTarefa() async {
    if (_tarefaField.text.trim().isNotEmpty && _user != null) {
      await _db.collection('users').doc(_user.uid).collection('tarefas').add({
        "titulo": _tarefaField.text.trim(),
        "concluida": false,
        "criadaEm": DateTime.now(),
      });
      _tarefaField.clear();
    }
  }

  //Atualiar status da tarefa

  // Deletar tarefa

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
