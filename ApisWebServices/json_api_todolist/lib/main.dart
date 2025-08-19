import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: TarefasPage()));
}

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key}); // Garantia da importação bem sucedida

  @override
  State<StatefulWidget> createState() {
    return _TarefasPageState();
  }
}

// Construção da logica e da tela para a mudança de estado
class _TarefasPageState extends State<TarefasPage> {
  // Atributos
  List<Map<String, dynamic>> tarefas =
      []; //Vetor para armazenar a coleção de tarefas
  final TextEditingController _TarefaController = TextEditingController();
  String baseUrl = "http://10.109.197.21:3001/tarefas";

  // Métodos
  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  void _carregarTarefas() async {
    try {
      // Fazer uma conexão http (instalar a biblioteca http)
      // Fazer uma solicitação get
      final response = await http.get(Uri.parse(baseUrl)); // String > Url
      if (response.statusCode == 200) {
        List<dynamic> dados = json.decode(response.body);
        setState(() {
          tarefas = dados
              .map(
                (item) => Map<String, dynamic>.from(item),
              ) // Convertendo a lista Json da dados em tarefa(item) por tarefa(item)
              .toList();
          // tarefas = dados
          //     .cast<
          //       Map<String, dynamic>
          //     >(); // Mais fácil, porem tende a dar mais erros
          // tarefas = List<Map<String, dynamic>>.from(dados); // Pode vir a dar erro também
        });
      }
    } catch (e) {
      print("Erro ao Carregar Tarefas: $e");
    }
  }

  // Post (inserir)
  void _adicionarTarefa(String titulo) async {
    try {
      final tarefa = {"titulo": titulo, "concluida": false}; // Map -> Dart
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-type": "application/json"},
        body: json.encode(tarefa), // Map/dart -> Text/json
      );
      if (response.statusCode == 201) {
        _TarefaController.clear();
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Adicionada com Sucesso!"),
          duration: Duration(milliseconds: 650),),
        );
      }
    } catch (e) {
      print("Erro ao inserir Tarefa: $e");
    }
  }

  // Patch ou put (atualiza)
  void _atualizarTarefa(String id, bool concluida) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"concluida": concluida}),
      );
      if (response.statusCode == 200) {
        _atualizarTarefa(id, concluida);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Atualizada com Sucesso"),
          duration: Duration(milliseconds: 650),),
        );
      }
    } catch (e) {
      print("Erro ao Atualizar Tarefa: $e");
    }
  }

  // Delete
  void _removerTarefa(String id) async {
    try {
      // Solicitação http -> delete (URl = ID)
      final response = await http.delete(Uri.parse("$baseUrl/$id"));
      if (response.statusCode == 200) {
        _carregarTarefas();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Tarefa Removida com Sucesso!!"),
          duration: Duration(milliseconds: 650)),
        );
      }
    } catch (e) {
      print("Erro ao remover tarefa: $e");
    }
  }

  // Build da tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tarefas Via API")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _TarefaController,
              decoration: InputDecoration(
                labelText: "Nova Tarefa",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _adicionarTarefa,
            ),
            SizedBox(height: 10),
            Expanded(
              // Operador ternario
              child: tarefas.isEmpty
                  ? Center(child: Text("Nenhuma Tarefa Adicionada"))
                  : ListView.builder(
                      itemCount: tarefas.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefas[index];
                        return ListTile(
                          //elemento do ListView
                          //leading (checkBox) -Atualizar conclusão da tarefa
                          leading: Checkbox(
                            value: tarefa["concluida"],
                            onChanged: (bool? value) {
                              if (value != null) {
                                _atualizarTarefa(tarefa["id"], value);
                                setState(() {
                                  tarefas[index]["concluida"] = value;
                                });
                              }
                            },
                          ),
                          title: Text(tarefa["titulo"]),
                          subtitle: Text(
                            tarefa["concluida"] ? "Concluida" : "Pendente",
                          ),
                          trailing: IconButton(
                            onPressed: () => _removerTarefa(tarefa["id"]),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
