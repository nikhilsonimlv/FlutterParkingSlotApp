import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/loading.dart';

void main() {
  group('Loading widget', () {
    testWidgets('loading Widget', (WidgetTester tester) async {
      // Given
      const testWidget = MaterialApp(
        home: Scaffold(
          body: Loading(),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      var loading = find.byType(Loading);
      var align = find.byType(Align);
      var cpI = find.byType(CircularProgressIndicator);

      // Then
      expect(loading, findsOneWidget);
      expect(align, findsOneWidget);
      expect(cpI, findsOneWidget);
      var container = find.byKey(const Key("loading_container"));
      expect(container, findsOneWidget);

      final containerWidget = tester.widget<Container>(container);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(decoration.color, Colors.black.withOpacity(0.3));
      expect(
        decoration.borderRadius,
        const BorderRadius.all(
          Radius.circular(10.0),
        ),
      );

      final circularProgressWidget = tester.widget<CircularProgressIndicator>(cpI);
      expect(circularProgressWidget.backgroundColor, Colors.white);
    });
  });
}
