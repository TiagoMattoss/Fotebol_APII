import 'dart:convert'; // Fornece funções para codificar e decodificar JSON.
import 'package:http/http.dart';
import 'soccermodel.dart';

class SoccerApi {
  // é responsável por fazer a chamada à API e obter os dados das partidas.

  final String apiUrl =
      "https://v3.football.api-sports.io/fixtures?season=2020&league=39"; // armazena a URL do endpoint da API que será chamada

  static const headers = {
    // armazena os cabeçalhos que serão enviados junto com a requisição HTTP
    'x-rapidapi-host': "v3.football.api-sports.io",

    'x-rapidapi-key':
        "94b2f8f9d19430b18a8f0781cbe14d29" // É necessários para autenticação na API.
  };

  //É um metodo responsável por fazer a requisição HTTP para a API e retornar uma lista de objetos SoccerMatch
  Future<List<SoccerMatch>> getAllMatches() async {
    Response res = await get(Uri.parse(apiUrl), headers: headers);

    var body;

    if (res.statusCode == 200) {
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service: ${body}");
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    }
  }
}
