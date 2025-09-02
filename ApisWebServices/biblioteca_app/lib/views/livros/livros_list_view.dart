import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/views/livros/livros_form_view.dart';
import 'package:flutter/material.dart';

class LivrosListView extends StatefulWidget {
  const LivrosListView({super.key});

  @override
  State<LivrosListView> createState() => _LivroListViewState();
}

class _LivroListViewState extends State<LivrosListView> {
  //atributos
  final _buscarField = TextEditingController();
  List<LivroModel> _livrosFiltrados = [];
  final _controller = LivroController(); //controller para conectar movel/view
  List<LivroModel> _livros = []; //lista par guardar os usuário
  bool _carregando = true; //bool par usar no view

  @override
  void initState() {
    // carregar os dados antes da contrução da tela
    super.initState();
    _load(); //método par carregar dados da api
  }

  _load() async {
    setState(() {
      _carregando = true;
    });
    try {
      _livros = await _controller
          .pegueTodos(); //preenche a lista de usuário com os livro do BD
      _livrosFiltrados = _livros;
    } catch (e) {
      //caso erro mostra para o usuário
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      // modifica a variável para false - terminou de carregar
      _carregando = false;
    });
  }

  //método para filtrar usuários pelo titulo e pelo autor
  void _filtrar() {
    //filtar da lista já carregada
    final busca = _buscarField.text.toLowerCase();
    setState(() {
      _livrosFiltrados = _livros.where((autor) {
        return autor.titulo.toLowerCase().contains(busca) || //filta pelo titulo
            autor.autor.toLowerCase().contains(busca); //filtra pelo autor
      }).toList(); //converte em Lista
    });
  }

  //criar método deletar
  void _delete(LivroModel autor) async {
    if (autor.id == null) return; //interrompe o método
    final confirme = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirma Exclusão"),
        content: Text("Deseja Realmente Excluir o Livro ${autor.titulo}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Ok"),
          ),
        ],
      ),
    );
    if (confirme == true) {
      try {
        await _controller.delete(autor.id!);
        _load();
        //mensagem de confirmação
      } catch (e) {
        //tratar erro
      }
    }
  }

  //método para navegar para Tela User_form_view

  void _openForm({LivroModel? autor}) async {
    //usuário entra no parametro, mas não é obrigatório
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LivrosFormView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // operador ternário
      body: _carregando
          ? Center(
              child: CircularProgressIndicator(),
            ) // mostra uma barra circular
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _buscarField,
                    decoration: InputDecoration(labelText: "Pesquisar Livro"),
                    onChanged: (value) => _filtrar(),
                  ),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    // ,mostra a lista de usuário
                    padding: EdgeInsets.all(8),
                    itemCount: _livrosFiltrados.length,
                    itemBuilder: (context, index) {
                      final livro = _livrosFiltrados[index];
                      return Card(
                        child: ListTile(
                          // leading oque vem antes do texto
                          leading: IconButton(
                            onPressed: () => _openForm(autor: livro),
                            icon: Icon(Icons.edit),
                          ),
                          title: Text(livro.titulo),
                          subtitle: Text(livro.autor),
                          //trailing para deletar livro
                          trailing: IconButton(
                            onPressed: () => _delete(livro),
                            icon: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
