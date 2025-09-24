//! classe para gerenciar o relacionamento do modelo com a classe
import 'dart:io';

import 'package:cine_favorite_formativa/models/favorite_movie_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FavoriteMovieController {
  //* atributos
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  //* Cria um user -> método para buscar o usuario log
  User? get currentUser => _auth.currentUser;

  //* métodos para favorite movie

  //* addFavorite - adiciona um filme a lista de favoritos
  void addFavorite(Map<String, dynamic> movieData) async {
    //* usar bibliotecas path e pathProvider para armazenar a img no meu dispositivo
    //* baixar a imagem da internet
    final imagemUrl =
        "https://image.tmdb.org/t/p/w500${movieData["poster_path"]}";
    final responseImg = await http.get(Uri.parse(imagemUrl));
    //* armazenar a imagem no dispositivo
    final imagemDir = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagemDir.path}/${movieData["id"]}.jpg");
    await imagemFile.writeAsBytes(responseImg.bodyBytes);

    //*criar o obj no db
    final movie = FavoriteMovie(
      id: movieData["id"],
      title: movieData["title"],
      posterPath: movieData["poster_path"],
    );
    //*adicionar o obj no firestore
    await _db
        .collection("user")
        .doc(currentUser!.uid)
        .collection("favorites_movies")
        .doc(movie.id.toString())
        .set(movie.toMap());
  }

  //*listFavorite -> pegar a lista de filmes no bd
  //*stream -> listener, pega a lista de favoritos sempre que for modificado
  Stream<List<FavoriteMovie>> getFavoriteMovies() {
    //* verifica se o usuario existe
    if (currentUser == null)
      return Stream.value([]); //*retorna a lista vazia se nao tem usuario
    return _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => FavoriteMovie.fromMap(doc.data()))
              .toList(),
        );
  }

  //*removeFavorite
  void removeFavoriteMovie(int movieId) async {
    if (currentUser == null) return;
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .delete();

    //*deletar a imagem do diretorio
    final imagePath = await getApplicationDocumentsDirectory();
    final imagemFile = File("${imagePath.path}/$movieId.jpg");
    try {
      await imagemFile.delete();
    } catch (e) {
      print("Erro ao deletar img");
    }
  }

  //*updateRating
  void updateMovieRating(int movieId, double rating) async {
    if (currentUser == null) return;
    await _db
        .collection("users")
        .doc(currentUser!.uid)
        .collection("favorite_movies")
        .doc(movieId.toString())
        .update({"rating":rating});
  }
}
