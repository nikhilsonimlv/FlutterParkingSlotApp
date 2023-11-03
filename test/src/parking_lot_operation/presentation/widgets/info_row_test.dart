import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/info_row.dart';

void main() {
  group('InfoRow widget', () {
    testWidgets('should be displayed when the widget is built', (WidgetTester tester) async {
      // Given
      const testWidget = MaterialApp(
        home: Scaffold(
          body: InfoRow(label: 'Label'),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      expect(find.byType(InfoRow), findsOneWidget);
    });

    testWidgets('should display the label property correctly', (WidgetTester tester) async {
      // Given
      const label = 'Label';
      const testWidget = MaterialApp(
        home: Scaffold(
          body: InfoRow(label: label),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final infoRow = tester.widget<InfoRow>(find.byType(InfoRow));
      expect(infoRow.label, label);
    });

    testWidgets('should display the value property correctly', (WidgetTester tester) async {
      // Given
      const value = 'Value';
      const testWidget = MaterialApp(
        home: Scaffold(
          body: InfoRow(label: 'Label', value: value),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final infoRow = tester.widget<InfoRow>(find.byType(InfoRow));
      expect(infoRow.value, value);
    });

    testWidgets('should display "N/A" if the value property is null', (WidgetTester tester) async {
      // Given
      const testWidget = MaterialApp(
        home: Scaffold(
          body: InfoRow(label: 'Label'),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final infoRow = tester.widget<InfoRow>(find.byType(InfoRow));
      expect(infoRow.value, null);
    });
  });
}
