import 'dart:convert';
import 'package:http/http.dart' as http;

import 'poke_info_model.dart';

class PokemonRepository {
  Future<PokeInfoModel> getInfoByID(String id) async {
    final url = Uri.https("pokeapi.co", "/api/v2/pokemon/$id");
    final res = await http.get(url);

    if (res.statusCode != 200) throw Exception();

    final json = jsonDecode(res.body);

    return PokeInfoModel.fromJson(json);
  }
}
