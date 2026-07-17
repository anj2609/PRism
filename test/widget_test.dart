import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prism/main.dart';

void main() {
  testWidgets('PrismApp renders splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PrismApp()));
    await tester.pump();

    expect(find.text('PRism'), findsOneWidget);
  });
}
