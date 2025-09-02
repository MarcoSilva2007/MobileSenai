import 'package:biblioteca_app/controllers/emprestimo_controller.dart';
import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:flutter/material.dart';

class EmprestimosFormView extends StatefulWidget {
  //atributos da classe
  final EmprestimoModel? user; //pode ser nulo

  const EmprestimosFormView({
    super.key,
    this.user,
  }); //usuário não é obrigatório no construtor

  @override
  State<EmprestimosFormView> createState() => _EmprestimoFormViewState();
}

class _EmprestimoFormViewState extends State<EmprestimosFormView> {
  //atributos
  final _formKey = GlobalKey<FormState>(); // validações do formulário
  final _controller = EmprestimoController(); //comunicação entre view e model
  final _nomeField = TextEditingController(); //controle o campo nome
  final _emailField = TextEditingController(); //controla o campo email

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nomeField.text = widget
          .user!
          .nome; //atribui ao campo do formulário as informações do usuário que veio da tela anterior
      _emailField.text = widget.user!.email;
    }
  }

  //criar novo usuario
  void _criar() async {
    if (_formKey.currentState!.validate()) {
      final usuarioNovo = EmprestimoModel(
        id: DateTime.now().millisecond.toString(),
        nome: _nomeField.text.trim(),
        email: _emailField.text.trim(),
      );
      try {
        await _controller.create(usuarioNovo);
        // Mesnagem de usuario novo
      } catch (e)EmprestimoFormViewStatepop(context);
      // Volta para tela antEmprestimo  }
  }

  //atualizar utuário
  void _atualizar() async {
    if (_formKey.currentState!.validate()) {
      final usuarioAtualizado = EmprestimoModel(
        id: widget.user!.id,
        nome: _nomeField.text.trim(),
        email: _emailField.text.trim(),
      );
      try {
        await _controller.create(usuarioAtualizado);
        // Mensagem de usuario atualizado
      } catch (e)EmprestimoFormViewStatepop(context);
      // Volta para tela anteriorEmprestimo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // operador ternario
          widget.user == null ? "Novo Usuario" : "Editar Usuario",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeField,
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) => value!.isEmpty ? "Informe o Nome" : null,
              ),
              TextFormField(
                controller: _emailField,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) => value!.isEmpty ? "Informe o Email" : null,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: widget.user == null ? _criar : _atualizar,
                child: Text(widget.user == null ? "Salvar" : "Atualizar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
