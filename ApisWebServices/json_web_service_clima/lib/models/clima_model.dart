class ClimaModel {
  //atributos
  final String cidade;
  final double temperatura;
  final String descricao;

  // Construtor
  ClimaModel({
    required this.cidade,
    required this.temperatura,
    required this.descricao,
  });

  // Factory => apenas recebo informações e não escrevo nada
  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      cidade: json["name"],
      temperatura: json["main"]["temp"].toDouble(),
      descricao: json["weather"][0]["description"],
    );
  }
}
