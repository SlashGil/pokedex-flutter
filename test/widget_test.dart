import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/main.dart';

void main() {
  testWidgets('Pokedex app renders splash screen smoke test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: PokedexApp(),
      ),
    );

    expect(find.text('Pokédex'), findsOneWidget);

    // Fast forward timer to complete splash screen duration
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
