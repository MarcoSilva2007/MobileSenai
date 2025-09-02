import 'package:biblioteca_app/controllers/livro_controller.dart';
import 'package:biblioteca_app/models/livro_model.dart';
import 'package:flutter/material.dart';

class LivrosFormView extends StatefulWidget {
  //atributos da classe
  final LivroModel? livro; //pode ser nulo

  const LivrosFormView({
    super.key,
    this.livro,
  }); //usuário não é obrigatório no construtor

  @override
  State<LivrosFormView> createState() => _LivroFormViewState();
}

class _LivroFormViewState extends State<LivrosFormView> {
  //atributos
  final _formKey = GlobalKey<FormState>(); // validações do formulário
  final _controller = LivroController(); //comunicação entre view e model
  final _tituloField = TextEditingController(); //controle o campo titulo
  final _autorField = TextEditingController(); //controla o campo autor

  @override
  void initState() {
    super.initState();
    if (widget.livro != null) {
      _tituloField.text = widget
          .livro!
          .titulo; //atribui ao campo do formulário as informações do usuário que veio da tela anterior
      _autorField.text = widget.livro!.autor;
    }
  }

  //criar novo livro
  void _criar() async {
    if (_formKey.currentState!.validate()) {
      final livroNovo = LivroModel(
        id: DateTime.now().millisecond.toString(),
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel: true
      );
      try {
        await _controller.create(livroNovo);
        // Mensagem de livro novo
      } catch (e) {}
      Navigator.pop(context);
      // Volta para tela anterior
    }
  }

  //atualizar livro
  void _atualizar() async {
    if (_formKey.currentState!.validate()) {
      final livroAtualizado = LivroModel(
        id: widget.livro!.id,
        titulo: _tituloField.text.trim(),
        autor: _autorField.text.trim(),
        disponivel:false
      );
      try {
        await _controller.create(livroAtualizado);
        // Mensagem de livro atualizado
      } catch (e) {}
      Navigator.pop(context);
      // Volta para tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // operador ternario
          widget.livro == null ? "Novo Livro" : "Editar Livro",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloField,
                decoration: InputDecoration(labelText: "Titulo"),
                validator: (value) => value!.isEmpty ? "Informe o Titulo" : null,
              ),
              TextFormField(
                controller: _autorField,
                decoration: InputDecoration(labelText: "Autor"),
                validator: (value) => value!.isEmpty ? "Informe o Autor" : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: widget.livro == null ? _criar : _atualizar,
                child: Text(widget.livro == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
