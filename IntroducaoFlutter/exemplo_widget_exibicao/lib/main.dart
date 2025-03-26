import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

//classe de jaenla
class MyApp extends StatelessWidget {
  // construtor da widgets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição")),
      body: Center(
        child: Column(
          children: [
            Text(
              "Exemplo de texto",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            Text(
              "Texto personalizado",
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                letterSpacing: 2,
                wordSpacing: 2,
                decoration: TextDecoration.underline,
              ),
            ),
            Icon(Icons.star, size: 50, color: Colors.amber),
            IconButton(
              onPressed: () => print("Icone Pressionado"),
              icon: Icon(Icons.add_a_photo),
              iconSize: 50,
            ),
            Image.network(
              "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/03333008-3365-457a-8ad4-fbffb2c2371d/dgg4h4t-90beb80e-4ba8-447f-bf8e-90e595ca127d.jpg/v1/fill/w_1600,h_900,q_75,strp/into_the_spider_verse_suit_by_primalelf1512_dgg4h4t-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9OTAwIiwicGF0aCI6IlwvZlwvMDMzMzMwMDgtMzM2NS00NTdhLThhZDQtZmJmZmIyYzIzNzFkXC9kZ2c0aDR0LTkwYmViODBlLTRiYTgtNDQ3Zi1iZjhlLTkwZTU5NWNhMTI3ZC5qcGciLCJ3aWR0aCI6Ijw9MTYwMCJ9XV0sImF1ZCI6WyJ1cm46c2VydmljZTppbWFnZS5vcGVyYXRpb25zIl19.Hx4C2Kr2rB9cXUaX157HbUGD8tjunfsGzcJJnwSxQRs",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Image.asset(
              "assets/img/image.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            //Box para exibição de imagens
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/img/image.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/img/image.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
