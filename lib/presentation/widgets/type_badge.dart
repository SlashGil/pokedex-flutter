import 'package:flutter/material.dart';
import '../../core/theme/pokemon_types.dart';

class TypeBadge extends StatelessWidget {
  final String typeName;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const TypeBadge({
    super.key,
    required this.typeName,
    this.fontSize = 11,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    final color = PokemonTypes.getColor(typeName);
    final formattedName = typeName.isNotEmpty
        ? '${typeName[0].toUpperCase()}${typeName.substring(1)}'
        : typeName;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        formattedName,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
