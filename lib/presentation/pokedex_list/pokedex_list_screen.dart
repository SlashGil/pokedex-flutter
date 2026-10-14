import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/pokemon_types.dart';
import '../providers/pokemon_providers.dart';
import '../widgets/pokemon_card.dart';

class PokedexListScreen extends ConsumerWidget {
  const PokedexListScreen({super.key});

  static const List<String> typeFilters = [
    'All',
    'Grass',
    'Fire',
    'Water',
    'Electric',
    'Bug',
    'Normal',
    'Poison',
    'Ground',
    'Fairy',
    'Fighting',
    'Psychic',
    'Rock',
    'Ghost',
    'Ice',
    'Dragon',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredPokemonState = ref.watch(filteredPokemonListProvider);
    final selectedType = ref.watch(selectedTypeFilterProvider) ?? 'All';

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.catching_pokemon, color: AppTheme.primaryAccent, size: 28),
            SizedBox(width: 8),
            Text(
              'Pokédex',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Search Pokémon by name or #ID...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: Consumer(
                  builder: (context, ref, _) {
                    final query = ref.watch(searchQueryProvider);
                    if (query.isEmpty) return const SizedBox.shrink();
                    return IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        ref.read(searchQueryProvider.notifier).state = '';
                      },
                    );
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppTheme.primaryAccent, width: 1.5),
                ),
              ),
            ),
          ),

          // Type Filter Bar
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: typeFilters.length,
              itemBuilder: (context, index) {
                final type = typeFilters[index];
                final isSelected = selectedType.toLowerCase() == type.toLowerCase();
                final typeColor = type == 'All'
                    ? AppTheme.primaryAccent
                    : PokemonTypes.getColor(type);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(
                      type,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    selectedColor: typeColor,
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? typeColor : const Color(0xFFE0E0E0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onSelected: (bool selected) {
                      ref.read(selectedTypeFilterProvider.notifier).state =
                          selected ? type : 'All';
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Pokémon Grid
          Expanded(
            child: filteredPokemonState.when(
              data: (pokemonList) {
                if (pokemonList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Pokémon found',
                      style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: pokemonList.length,
                  itemBuilder: (context, index) {
                    return PokemonCard(pokemon: pokemonList[index]);
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppTheme.primaryAccent),
              ),
              error: (err, stack) => Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 12),
                      const Text(
                        'Failed to load Pokémon data.',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        err.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          ref.invalidate(pokemonListProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryAccent,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
