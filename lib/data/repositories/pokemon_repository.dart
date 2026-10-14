import 'package:graphql_flutter/graphql_flutter.dart';
import '../../core/graphql/graphql_service.dart';
import '../models/pokemon_model.dart';
import '../queries/pokemon_queries.dart';

class PokemonRepository {
  final GraphQLClient client;

  PokemonRepository({GraphQLClient? client})
      : client = client ?? GraphQLService.getRawClient();

  Future<List<Pokemon>> fetchPokemonList({int limit = 151, int offset = 0}) async {
    final QueryOptions options = QueryOptions(
      document: gql(PokemonQueries.getPokemonList),
      variables: {
        'limit': limit,
        'offset': offset,
      },
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    final List<dynamic>? pokemonData =
        result.data?['pokemon_v2_pokemon'] as List<dynamic>?;

    if (pokemonData == null) {
      return [];
    }

    return pokemonData.map((json) => Pokemon.fromJson(json as Map<String, dynamic>)).toList();
  }
}
