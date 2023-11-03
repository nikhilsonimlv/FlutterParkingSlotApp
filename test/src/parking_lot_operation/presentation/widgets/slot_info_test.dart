import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/slot_info.dart';

void main() {
  group('SlotInfoWidget widget', () {
    testWidgets('should be displayed when the widget is built', (WidgetTester tester) async {
      // Given
      const mockCarSize = CarSize.small;
      var testWidget = MaterialApp(
        home: Row(
          children: const [
            SlotInfoWidget(carSize: mockCarSize, totalCount: 10, availableCount: 5),
          ],
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      expect(find.byType(SlotInfoWidget), findsOneWidget);
    });

    testWidgets('should display the carSlotTypeValues.reverse[carSize] correctly', (WidgetTester tester) async {
      // Given
      const mockCarSize = CarSize.small;

      var testWidget = MaterialApp(
        home: Row(
          children: const [
            SlotInfoWidget(carSize: mockCarSize, totalCount: 10, availableCount: 5),
          ],
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final slotInfoWidget = tester.widget<SlotInfoWidget>(find.byType(SlotInfoWidget));
      expect(carSlotTypeValues.reverse[slotInfoWidget.carSize]!, 'Small');
    });

    testWidgets('should display the availableCount and totalCount - availableCount correctly', (WidgetTester tester) async {
      // Given
      const mockCarSize = CarSize.small;

      var testWidget = MaterialApp(
        home: Row(
          children: const [
            SlotInfoWidget(carSize: mockCarSize, totalCount: 10, availableCount: 5),
          ],
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final slotInfoWidget = tester.widget<SlotInfoWidget>(find.byType(SlotInfoWidget));
      expect(slotInfoWidget.availableCount, 5);
      expect(slotInfoWidget.totalCount - slotInfoWidget.availableCount, 5);
    });
  });
}
