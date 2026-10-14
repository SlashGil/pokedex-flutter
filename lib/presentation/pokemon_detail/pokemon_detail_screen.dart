import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../core/theme/pokemon_types.dart';
import '../../data/models/pokemon_model.dart';
import '../widgets/type_badge.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final primaryType = pokemon.types.isNotEmpty ? pokemon.types.first : 'normal';
    final primaryColor = PokemonTypes.getColor(primaryType);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                pokemon.formattedId,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Pokeball motif
          Positioned(
            right: -40,
            top: -20,
            child: Icon(
              Icons.catching_pokemon,
              size: 240,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),

          Column(
            children: [
              // Header Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pokemon.capitalizedName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: pokemon.types
                          .map((type) => Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: TypeBadge(
                                  typeName: type,
                                  fontSize: 13,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 6),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Bottom Info Card Sheet
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 90, 24, 24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Physical Metrics Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildMetricItem(
                                label: 'Weight',
                                value: '${pokemon.weight} kg',
                                icon: Icons.scale,
                              ),
                              Container(height: 40, width: 1, color: Colors.grey.shade300),
                              _buildMetricItem(
                                label: 'Height',
                                value: '${pokemon.height} m',
                                icon: Icons.height,
                              ),
                            ],
                          ),

                          const SizedBox(height: 32),

                          // Base Stats Title
                          const Text(
                            'Base Stats',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A2A2A),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Stats List
                          ..._buildStatRows(primaryColor),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Overlapping Pokémon Artwork
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Hero(
                tag: 'pokemon-image-${pokemon.id}',
                child: CachedNetworkImage(
                  imageUrl: pokemon.imageUrl,
                  height: 160,
                  width: 160,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const SizedBox(
                    height: 160,
                    child: Center(child: CircularProgressIndicator(color: Colors.white)),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.catching_pokemon,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A2A2A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
        ),
      ],
    );
  }

  List<Widget> _buildStatRows(Color barColor) {
    final Map<String, String> statDisplayNames = {
      'hp': 'HP',
      'attack': 'ATK',
      'defense': 'DEF',
      'special-attack': 'SATK',
      'special-defense': 'SDEF',
      'speed': 'SPD',
    };

    return statDisplayNames.entries.map((entry) {
      final statKey = entry.key;
      final label = entry.value;
      final value = pokemon.stats[statKey] ?? 0;
      final double progress = (value / 200.0).clamp(0.0, 1.0);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF757575),
                ),
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2A2A2A),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFF0F0F0),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress > 0.5 ? barColor : Colors.orangeAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
