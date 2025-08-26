import 'package:biblioteca_app/models/emprestimo_model.dart';
import 'package:biblioteca_app/services/api_service.dart';

class EmprestimoController {
  // Métodos

  // GET all
  Future<List<EmprestimoModel>> pegueTodos() async {
    final list = await ApiService.getList("emprestimos");
    return list
        //retorna a lista de emprestimos (json) convertida para usaurio model (DART)
        .map<EmprestimoModel>((item) => EmprestimoModel.fromJson(item))
        .toList();
  }

  // GET one
  Future<EmprestimoModel> pegueUm(String id) async {
    final emprestimo = await ApiService.getOne("emprestimos", id);
    return EmprestimoModel.fromJson(emprestimo);
  }

  // POST
  Future<EmprestimoModel> create(EmprestimoModel user) async {
    final created = await ApiService.post("emprestimo", user.toJson());
    // adicionar o usuário e retorna o emprestimo selecionado
    return EmprestimoModel.fromJson(created);
  }

  //PUT
  Future<EmprestimoModel> update(EmprestimoModel user) async {
    final updated = await ApiService.put("emprestimos", user.toJson(), user.id!);
    // retorna um usaurio autorizado
    return EmprestimoModel.fromJson(updated);
  }

  // DELETE
  Future<void> delete(String id) async {
    await ApiService.delete("emprestimos", id);
  }
}
