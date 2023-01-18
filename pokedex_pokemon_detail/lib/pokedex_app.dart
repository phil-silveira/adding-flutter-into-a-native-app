import 'package:flutter/cupertino.dart';
import 'package:pokedex_pokemon_detail/views/not_found_page.dart';

import 'views/pokemon_detail_page.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        final routeName = settings.name?.split("?").first ?? "";
        final Map<String, dynamic> routeArgs = {};
        for (String param in settings.name?.split("?").last.split("&") ?? []) {
          final keyValue = param.split("=");
          routeArgs[keyValue.first] = keyValue.last;
        }

        if (routeName.startsWith(PokemonDetail.route)) {
          return CupertinoPageRoute(
            builder: (_) => PokemonDetail(id: routeArgs['id']),
          );
        }
        return CupertinoPageRoute(builder: (_) => const NotFoundPage());
      },
    );
  }
}
