class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final double height; // in meters
  final double weight; // in kg
  final String imageUrl;
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.stats,
  });

  String get formattedId => '#${id.toString().padLeft(3, '0')}';

  String get capitalizedName =>
      name.isNotEmpty ? '${name[0].toUpperCase()}${name.substring(1)}' : name;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final int pokeId = json['id'] as int;

    final List<dynamic> typesData = json['pokemon_v2_pokemontypes'] as List<dynamic>? ?? [];
    final List<String> extractedTypes = typesData
        .map((t) => t['pokemon_v2_type']['name'].toString())
        .toList();

    final List<dynamic> statsData = json['pokemon_v2_pokemonstats'] as List<dynamic>? ?? [];
    final Map<String, int> extractedStats = {};
    for (var s in statsData) {
      final statName = s['pokemon_v2_stat']['name'].toString();
      final baseStat = s['base_stat'] as int;
      extractedStats[statName] = baseStat;
    }

    // Official artwork CDN URL
    final String artworkUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$pokeId.png';

    final int rawHeight = (json['height'] as int?) ?? 0;
    final int rawWeight = (json['weight'] as int?) ?? 0;

    return Pokemon(
      id: pokeId,
      name: json['name'] as String? ?? '',
      types: extractedTypes,
      height: rawHeight / 10.0, // Convert decimeters to meters
      weight: rawWeight / 10.0, // Convert hectograms to kg
      imageUrl: artworkUrl,
      stats: extractedStats,
    );
  }
}
