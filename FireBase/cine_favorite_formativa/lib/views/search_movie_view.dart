import 'package:cine_favorite_formativa/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite_formativa/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  //* atributos
  final _favMovieController = FavoriteMovieController();
  final _searchField = TextEditingController();

  List<Map<String, dynamic>> _movie = [];

  bool _isLoading = false;

  //*método
  void _searchMovies() async {
    //* pegar o text que será inserido
    final termo = _searchField.text.trim();
    if (termo.isEmpty) return;

    setState(() {
      _isLoading = true;
    });
    //* busca o termo na API
    try {
      final result = await TmdbService.searchMovie(termo);
      setState(() {
        _movie = result;
      });
    } catch (e) {
      setState(() {
        _movie = [];
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar Filmes")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchField,
              decoration: InputDecoration(
                labelText: "Nome do Filme",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _searchMovies,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            //* Listar os filmes encontrados na API
            SizedBox(height: 10),
            //* Operador Ternario
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _movie.length,
                      itemBuilder: (context, index) {
                        final movie = _movie[index];
                        return ListTile(
                          leading: Image.network(
                            "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                            height: 50,
                          ),
                          title: Text(movie["title"]),
                          subtitle: Text(movie["release_date"]),
                          trailing: IconButton(
                            onPressed: () async {
                              _favMovieController.addFavorite(movie);
                              //* mensagem
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${movie["title"]} adicionado com sucesso",
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.add),
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
