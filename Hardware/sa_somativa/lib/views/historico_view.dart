// lib/screens/historico_screen.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoricoView extends StatelessWidget {
  const HistoricoView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final formatter = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Pontos')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('registros')
            .where('userId', isEqualTo: user.uid)
            .orderBy('dataHora', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhum registro encontrado.'));
          }

          final registros = snapshot.data!.docs;

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              var doc = registros[index];
              var data = (doc['dataHora'] as Timestamp).toDate();
              String tipo = doc['tipo'];
              String cor = tipo == 'entrada' ? '🟢' : '🔴';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('$cor ${tipo.toUpperCase()}'),
                  subtitle: Text(formatter.format(data)),
                  trailing: Text(
                    '${doc['latitude'].toStringAsFixed(4)}, ${doc['longitude'].toStringAsFixed(4)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}