// Teste de conversão de Json > Dart e Dart > Json
import 'dart:convert'; // Biblioteca nativa, não necessario isntalar no pubspec

void main() {
  String // Possuo um texto em fomrato JSON
  UsuarioJson = /*Ao colocar 3 aspas simples (''') eu consigo quebrando as linhas */
      '''{ 
  "id": "1ab2",
  "user": "usuario1",
  "nome": "Pedro",
  "idade": 25,
  "cadastrado": true
    }'''; // Para manipular o texto uso o converter(decode) JSON em MAP
  Map<String, dynamic> usuario = json.decode(
    UsuarioJson,
  ); // Uma lista não ordenada, chamada por chave e valor onde eu manipulo as informações de JSON em MAP
  print(usuario["idade"]);
  usuario["idade"] = 26;
  // Converter (encode) de MAP em JSON
  UsuarioJson = json.encode(usuario);
  // E então eu tenho novamente um JSON em formato de Texto
  print(UsuarioJson);
}
