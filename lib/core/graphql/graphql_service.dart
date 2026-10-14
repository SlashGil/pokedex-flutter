import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  static const String pokeApiEndpoint = 'https://beta.pokeapi.co/graphql/v1beta';

  static ValueNotifier<GraphQLClient> initClient() {
    final HttpLink httpLink = HttpLink(pokeApiEndpoint);

    return ValueNotifier(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
  }

  static GraphQLClient getRawClient() {
    final HttpLink httpLink = HttpLink(pokeApiEndpoint);
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }
}
