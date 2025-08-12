import 'dart:convert';
import 'dart:io'; // Caminho para acessar os caminhos do armazenamento do celular

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: ProdutoPage()));
}

class ProdutoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProdutoPageState();
  }
}

class _ProdutoPageState extends State<ProdutoPage> {
  List<Map<String, dynamic>> produtos = []; // Lista para armazenar os produtos
  final TextEditingController _nomeController =
      TextEditingController(); // Fomrulario para armazenar o nome do produto
  final TextEditingController _valorController =
      TextEditingController(); // Formulario para armazenar o valor do produto

  // Carregar as informações no inicio do app
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _carregarProdutos();
  }

  // Método para conexão com a base de dados

  Future<File> _getArquivo() async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/produtos.json");
  }

  void _salvarProdutos() async {
    final file = await _getArquivo();
    String jsonProdutos = json.encode(produtos);
    await file.writeAsString(jsonProdutos);
  }

  void _carregarProdutos() async {
    try {
      final file = await _getArquivo();
      String conteudo = await file.readAsString();
      List<dynamic> dados = json.decode(conteudo);
      setState(() {
        produtos = dados.cast<Map<String, dynamic>>();
      });
    } catch (e) {
      setState(() {
        produtos = [];
      });
    }
  }

  void _adicionarProdutos() {
    String nome = _nomeController.text.trim();
    String valorStr = _valorController.text.trim();
    if (nome.isEmpty || valorStr.isEmpty) return;
    double? valor = double.tryParse(valorStr);
    if (valor == null) return;
    final novoProduto = {"nome": nome, "valor": valor};
    setState(() {
      produtos.add(novoProduto);
    });
    _nomeController.clear();
    _valorController.clear();
    _salvarProdutos();
  }

  void _removerProduto(int index) {
    setState(() {
      produtos.removeAt(index);
    });
    _salvarProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro de Produtos")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome do Produto"),
            ),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(labelText: "Valor (ex: 15.55)"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _adicionarProdutos,
              child: Text("Adicionar Produtos"),
            ),
            SizedBox(height: 10),
            Divider(),
            Expanded(
              child: produtos.isEmpty
                  ? Center(child: Text("Nenhum Produto Cadastrado"))
                  : ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        final produto = produtos[index];
                        return ListTile(
                          title: Text(produto["nome"]),
                          subtitle: Text("R\$ ${produto["valor"].toString()}"),
                          trailing: IconButton(
                            onPressed: () => _removerProduto(index),
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
