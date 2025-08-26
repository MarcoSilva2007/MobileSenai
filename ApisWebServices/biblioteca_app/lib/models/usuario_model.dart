class UsuarioModel {
  // atributos
  final String? id; //pode ser nulo
  final String nome;
  final String email;

  //constructor
  UsuarioModel({this.id, required this.nome, required this.email});

  //Métodos
  //toJson
  Map<String, dynamic> toJson() => {"id": id, "nome": nome, "email": email};

  // FromJson
  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
    id: json["id"].toString(),
    nome: json["nome"].toString(),
    email: json["email"].toString(),
  );
}
