import 'package:biblioteca_app/models/usuario_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UsuarioController {
  // Métodos

  // GET all
  Future<List<UsuarioModel>> pegueTodos() async {
    final list = await ApiService.getList("usuarios?_sort=nome");
    return list
        //retorna a lista de usuarios (json) convertida para usaurio model (DART)
        .map<UsuarioModel>((item) => UsuarioModel.fromJson(item))
        .toList();
  }

  // GET one
  Future<UsuarioModel> pegueUm(String id) async {
    final usuario = await ApiService.getOne("usuarios", id);
    return UsuarioModel.fromJson(usuario);
  }

  // POST
  Future<UsuarioModel> create(UsuarioModel user) async {
    final created = await ApiService.post("usuario", user.toJson());
    // adicionar o usuário e retorna o usuario selecionado
    return UsuarioModel.fromJson(created);
  }

  //PUT
  Future<UsuarioModel> update(UsuarioModel user) async {
    final updated = await ApiService.put("usuarios", user.toJson(), user.id!);
    // retorna um usaurio autorizado
    return UsuarioModel.fromJson(updated);
  }

  // DELETE
  Future<void> delete(String id) async {
    await ApiService.delete("usuarios", id);
  }
}
