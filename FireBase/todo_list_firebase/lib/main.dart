import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/firebase_options.dart';
import 'package:todo_list_firebase/views/auth_widget.dart';

void main() async {
  // Conexão com o firebase
  // Garantir o carregamento primeiro dos binding
  WidgetsFlutterBinding.ensureInitialized();
  // Iniciar o firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Garante a conexão somente com android
  );

  runApp(MaterialApp(
    title: "Lista de Tarefas Firebase",
    home: AuthWidget(), // Ela é uma tela que decide qual tela mostrar
  ));
}

