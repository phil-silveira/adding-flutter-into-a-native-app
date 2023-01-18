import 'package:pokedex_pokemon_detail/models/poke_info_model.dart';
import 'package:pokedex_pokemon_detail/models/pokemon_ios_secrets_repository.dart';
import 'package:pokedex_pokemon_detail/models/pokemon_repository.dart';

class PokemonInfoController {
  final repository = PokemonRepository();

  Future<PokeInfoModel> getPokemonInfoByID(String id) async {
    final info = await repository.getInfoByID(id);

    return info;
  }

  Future<String> getSecretKey() async {
    final key = await PokemonIosSecretsRepository.getSecretKey();

    return key;
  }
}
