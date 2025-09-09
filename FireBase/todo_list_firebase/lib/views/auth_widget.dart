// Widget de aunteticação de usuario => direcionar o usuario logado para as telas

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login_view.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //Direcionamento de telas dinamico, direciona o usuario de acordo com as informações salvas no cache
    // (snapshot)
    return StreamBuilder<User?>(
      // O stream builder vai depender do usuario
      stream: FirebaseAuth.instance
          .authStateChanges(), // Modifica o caminho ao mudar o estado do usuário
      builder: (context, snapshot) {
        if (snapshot.hasData) { // Se tem dados significa que o usuario esta logado
          return TarefasView();
        }
        return LoginView();
      },
    );
  }
}
