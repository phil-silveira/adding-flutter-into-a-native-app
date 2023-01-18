import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex_pokemon_detail/controlleres/pokemon_info_controller.dart';
import 'package:pokedex_pokemon_detail/models/poke_info_model.dart';

extension on String {
  String get capitalized {
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }
}

class PokemonDetail extends StatelessWidget {
  static const route = '/pokemon/detail';

  final String id;
  final controller = PokemonInfoController();

  PokemonDetail({
    super.key,
    required this.id,
  });

  void _showAlertDialog(BuildContext context, String secret) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Secret'),
        content: Text('The secret key is <$secret>'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: FutureBuilder<PokeInfoModel>(
        future: controller.getPokemonInfoByID(id),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            case ConnectionState.done:
              final pokemon = snapshot.data;

              if (pokemon == null) return _PokeNotFoundContent();

              return SafeArea(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const _IOSBackButton(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _InfoHeader(
                                backgroundImage: pokemon.image,
                                title: pokemon.name,
                                subtitle: pokemon.order,
                              ),
                              _ListOfTypes(types: pokemon.types),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: CupertinoButton(
                                  child: const Text('Secrets'),
                                  onPressed: () async {
                                    final res = await controller.getSecretKey();

                                    // TODO: Async use of context is not a best practice
                                    _showAlertDialog(context, res);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

class _InfoHeader extends StatelessWidget {
  final String backgroundImage;
  final String title;
  final String subtitle;

  const _InfoHeader({
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .35,
      child: Stack(
        children: [
          Image.network(backgroundImage),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.4),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: CupertinoColors.label,
                  ),
                ),
                Text(
                  title.capitalized,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    color: CupertinoColors.label,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IOSBackButton extends StatelessWidget {
  const _IOSBackButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(Icons.arrow_back_rounded)),
        onTap: () {
          SystemNavigator.pop();
        },
      ),
    );
  }
}

class _ListOfTypes extends StatelessWidget {
  final List<PokeTypes> types;

  const _ListOfTypes({required this.types});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: types
          .map(
            (t) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: t.color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                t.name.capitalized,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey6,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _PokeNotFoundContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Ops, pokemon not found :("),
    );
  }
}
