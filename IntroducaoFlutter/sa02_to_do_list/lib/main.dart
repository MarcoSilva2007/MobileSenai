
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ToDoListApp()),
  ); //Função principal
}

// Janela do aplicativo
// StateFull Widget
class ToDoListApp extends StatefulWidget {
  const ToDoListApp({super.key});

  // Classe que realiza a mudança de estado
  @override
  _ToDoListAppState createState() => _ToDoListAppState();
}

class _ToDoListAppState extends State<ToDoListApp> {
  // A classe que constroi todo o aplicativo
  final TextEditingController _tarefaController = TextEditingController();
  final List<Map<String, dynamic>> _tarefas = [];
  // Lista de tarefas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de tarefas"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _tarefaController,
              decoration: InputDecoration(labelText: "Digite uma tarefa"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _adicionarTarefa,
              child: Text("Adicionar Tarefa"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text(
                        _tarefas[index]["titulo"],
                        style: TextStyle(
                          decoration:
                              _tarefas[index]["concluida"]
                                  ? TextDecoration.lineThrough
                                  : null, // Operador ternário
                        ),
                      ),
                      leading: Checkbox(
                        value: _tarefas[index]["concluida"],
                        onChanged:
                            (bool? valor) => setState(() {
                              _tarefas[index]["concluida"] = valor!;
                            }),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _removerTarefasConcluidas,
        backgroundColor: Colors.red,
        child: Text("Remove"),
      ),
    );
  }

  void _adicionarTarefa() {
    if (_tarefaController.text.trim().isNotEmpty) {
      setState(() {
        _tarefas.add({"titulo": _tarefaController.text, "concluida": false});
        _tarefaController.clear(); // Limpa o campo de texto
      });
    }
  }

  void _removerTarefasConcluidas() {
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa["concluida"]);
      // Remove as tarefas que estão marcadas como concluídas
    });
  }
}
