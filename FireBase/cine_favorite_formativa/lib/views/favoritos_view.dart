//! Tela inicial do Aplicativo

import 'dart:io';

import 'package:cine_favorite_formativa/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite_formativa/models/favorite_movie_model.dart';
import 'package:cine_favorite_formativa/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoritosView extends StatefulWidget {
  const FavoritosView({super.key});

  @override
  State<FavoritosView> createState() => _FavoritosViewState();
}

class _FavoritosViewState extends State<FavoritosView> {
  final _favMovieController = FavoriteMovieController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus filmes favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<FavoriteMovie>>(
        stream: _favMovieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar a lista de favoritos"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favoriteMovies = snapshot.data!;
          if (favoriteMovies.isEmpty) {
            return const Center(child: Text("Nenhum filme adicionado aos favoritos"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () async {
                          _favMovieController.removeFavoriteMovie(movie.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${movie.title} removido dos favoritos")),
                          );
                        },
                        child: Image.file(File(movie.posterPath), fit: BoxFit.cover,)
                      ),
                    ),
                    Center(child: Text(movie.title)),
                    Center(child: Text("Nota do Filme: ${movie.rating}")),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchMovieView()),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}