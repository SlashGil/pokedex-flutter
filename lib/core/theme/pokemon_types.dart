import 'package:flutter/material.dart';

class PokemonTypes {
  static const Map<String, Color> _typeColors = {
    'grass': Color(0xFF7AC74C),
    'fire': Color(0xFFEE8130),
    'water': Color(0xFF6390F0),
    'electric': Color(0xFFF7D02C),
    'ice': Color(0xFF96D9D6),
    'fighting': Color(0xFFC22E28),
    'poison': Color(0xFFA33EA1),
    'ground': Color(0xEFE2BF65),
    'flying': Color(0xFFA98FF3),
    'psychic': Color(0xFFF95587),
    'bug': Color(0xFFA6B91A),
    'rock': Color(0xFFB6A136),
    'ghost': Color(0xFF735797),
    'dragon': Color(0xFF6F35FC),
    'dark': Color(0xFF705746),
    'steel': Color(0xFFB7B7CE),
    'fairy': Color(0xFFD685AD),
    'normal': Color(0xFFA8A878),
  };

  static Color getColor(String typeName) {
    final key = typeName.toLowerCase().trim();
    return _typeColors[key] ?? const Color(0xFFA8A878);
  }
}
