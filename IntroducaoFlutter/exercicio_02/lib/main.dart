import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> imagens = [
    "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0",
    "https://images.unsplash.com/photo-1521747116042-5a810fda9664",
    "https://images.unsplash.com/photo-1504384308090-c894fdcc538d",
    "https://images.unsplash.com/photo-1518837695005-2083093ee35b",
    "https://images.unsplash.com/photo-1501594907352-04cda38ebc29",
    "https://images.unsplash.com/photo-1519681393784-d120267933ba",
    "https://images.unsplash.com/photo-1531259683007-016a7b628fc3",
    "https://images.unsplash.com/photo-1506619216599-9d16d0903dfd",
    "https://images.unsplash.com/photo-1494172961521-33799ddd43a5",
    "https://images.unsplash.com/photo-1517245386807-bb43f82c33c4",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Galeria de Imagens"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _adicionarImagem(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: imagens.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => _mostrarImagem(context, imagens[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(imagens[index], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarImagem(BuildContext context, String imagem) {
    showDialog(
      context: context,
      builder: (context) => Dialog(child: Image.network(imagem)),
    );
  }

  void _adicionarImagem(BuildContext context) {
    TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Adicionar Nova Imagem"),
        content: TextField(
          controller: urlController,
          decoration: InputDecoration(hintText: "Digite a URL da imagem"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isNotEmpty) {
                setState(() {
                  imagens.add(urlController.text);
                });
              }
              Navigator.of(context).pop();
            },
            child: Text("Adicionar"),
          ),
        ],
      ),
    );
  }
}