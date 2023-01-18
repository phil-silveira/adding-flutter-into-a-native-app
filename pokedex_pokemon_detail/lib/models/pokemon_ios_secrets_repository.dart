import 'package:flutter/services.dart';

class PokemonIosSecretsRepository {
  const PokemonIosSecretsRepository._();

  static const MethodChannel _channel =
      MethodChannel('br.edu.pss.pokedex/secrets');

  static Future<String> getSecretKey() async {
    try {
      final String res = await _channel.invokeMethod('getSecretKey');

      return res;
    } on PlatformException catch (_) {
      return 'Erro ao se comunicar com o iOS';
    }
  }
}
