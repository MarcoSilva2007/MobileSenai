import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercicio Layout")),
      body: Center(
        child: Column(
          children: [
            Image.network(
              "https://img.freepik.com/vetores-premium/icone-de-perfil-de-usuario-em-estilo-plano-ilustracao-em-vetor-avatar-membro-em-fundo-isolado-conceito-de-negocio-de-sinal-de-permissao-humana_157943-15752.jpg?semt=ais_hybrid",
              scale: 2,
            ),
            Text(
              "Pefil",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Text("Esse é o meu perfil", style: TextStyle(fontSize: 17)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.facebook, size: 50, color: Colors.blueAccent),
                Icon(Icons.email, size: 50, color: Colors.red),
                Icon(Icons.phone, size: 50, color: Colors.green),
                Icon(Icons.discord, size: 50, color: Colors.blueAccent),
              ],
            ),
            SizedBox(height: 20), // Espaço entre os ícones e as caixas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Texto 1")),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.network(
                      "https://images.icon-icons.com/2107/PNG/512/file_type_flutter_icon_130599.png",
                      scale: 1,
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text("Caixa 3")),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.black, // Cor da linha
              thickness: 2, // Espessura da linha
              indent: 20, // Margem à esquerda
              endIndent: 20, // Margem à direita
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text("Texto 1", style: TextStyle(fontSize: 17)),
                Text("Texto 2", style: TextStyle(fontSize: 17)),
                Text("Texto 3", style: TextStyle(fontSize: 17)),
                Text("Texto 4", style: TextStyle(fontSize: 17)),
                Text("Texto 5", style: TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: "Voltar",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}