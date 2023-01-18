import 'dart:ui';

import 'package:flutter/foundation.dart';

class PokeInfoModel {
  final int id;
  final String order;
  final String name;
  final String sprite;
  final String image;
  final List<PokeTypes> types;

  PokeInfoModel(
      this.id, this.order, this.name, this.image, this.sprite, this.types);

  PokeInfoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        order = (json['order'] as int).toString().padLeft(3, '0'),
        name = json['name'],
        sprite = json['sprites']['front_default'],
        image = json['sprites']['other']['official-artwork']['front_default'],
        types = (json['types'] as List<dynamic>)
            .map((x) => PokeTypes.fromString(x['type']['name']))
            .toList();
}

enum PokeTypes {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  eletric,
  psychic,
  ice,
  dragon,
  dark,
  unknown,
  shadow;

  static PokeTypes fromString(String text) {
    for (var t in PokeTypes.values) {
      if (t.name == text) return t;
    }
    return PokeTypes.unknown;
  }

  String get name => describeEnum(this);
  Color get color {
    switch (this) {
      case PokeTypes.grass:
        return const Color(0xff88ee88);
      case PokeTypes.poison:
        return const Color(0xffee88ee);
      case PokeTypes.fire:
        return const Color(0xffee8888);
      case PokeTypes.water:
        return const Color(0xff8888ee);
      case PokeTypes.eletric:
        return const Color.fromARGB(255, 227, 213, 54);

      default:
        return const Color(0xffffffff);
    }
  }
}
