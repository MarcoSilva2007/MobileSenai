// classe de modelagem de dados para movie

class FavoriteMovie {
  //* atributos
  final int id;
  final String title;
  final String posterPath;
  double rating;

  //* construtor
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0,
  });

  //* métodos de conversão de obj <=> json
  //*toMap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  //*fromMap
  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map["id"], 
      title: map["title"], 
      posterPath: map["posterPath"],
      rating: (map["rating"] as num).toDouble()
    );
  }
}
