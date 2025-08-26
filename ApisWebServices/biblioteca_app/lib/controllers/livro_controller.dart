import 'package:biblioteca_app/models/livro_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LivroController {
  // Métodos

  // GET all
  Future<List<LivroModel>> pegueTodos() async {
    final list = await ApiService.getList("livros?_sort=titulo");
    return list
        //retorna a lista de livros (json) convertida para usaurio model (DART)
        .map<LivroModel>((item) => LivroModel.fromJson(item))
        .toList();
  }

  // GET one
  Future<LivroModel> pegueUm(String id) async {
    final livro = await ApiService.getOne("livros", id);
    return LivroModel.fromJson(livro);
  }

  // POST
  Future<LivroModel> create(LivroModel user) async {
    final created = await ApiService.post("livro", user.toJson());
    // adicionar o usuário e retorna o livro selecionado
    return LivroModel.fromJson(created);
  }

  //PUT
  Future<LivroModel> update(LivroModel user) async {
    final updated = await ApiService.put("livros", user.toJson(), user.id!);
    // retorna um usaurio autorizado
    return LivroModel.fromJson(updated);
  }

  // DELETE
  Future<void> delete(String id) async {
    await ApiService.delete("livros", id);
  }
}
