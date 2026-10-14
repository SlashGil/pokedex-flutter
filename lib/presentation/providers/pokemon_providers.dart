import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/pokemon_model.dart';
import '../../data/repositories/pokemon_repository.dart';

final pokemonRepositoryProvider = Provider<PokemonRepository>((ref) {
  return PokemonRepository();
});

final pokemonListProvider = FutureProvider<List<Pokemon>>((ref) async {
  final repository = ref.watch(pokemonRepositoryProvider);
  return repository.fetchPokemonList(limit: 151, offset: 0);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final selectedTypeFilterProvider = StateProvider<String?>((ref) => null);

final filteredPokemonListProvider = Provider<AsyncValue<List<Pokemon>>>((ref) {
  final asyncPokemonList = ref.watch(pokemonListProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase().trim();
  final selectedType = ref.watch(selectedTypeFilterProvider)?.toLowerCase();

  return asyncPokemonList.whenData((pokemonList) {
    return pokemonList.where((pokemon) {
      final matchesSearch = searchQuery.isEmpty ||
          pokemon.name.toLowerCase().contains(searchQuery) ||
          pokemon.formattedId.contains(searchQuery) ||
          pokemon.id.toString() == searchQuery;

      final matchesType = selectedType == null ||
          selectedType.isEmpty ||
          selectedType == 'all' ||
          pokemon.types.any((t) => t.toLowerCase() == selectedType);

      return matchesSearch && matchesType;
    }).toList();
  });
});
