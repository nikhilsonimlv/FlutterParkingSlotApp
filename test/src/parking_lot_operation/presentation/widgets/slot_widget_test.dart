import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/slot_widget.dart';

void main() {
  testWidgets('SlotWidget displays correct information and handles onChanged', (WidgetTester tester) async {
    const CarSize carSize = CarSize.small;
    final TextEditingController textEditingController = TextEditingController();
    String? onChangedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SlotWidget(
            carSize: carSize,
            textEditingController: textEditingController,
            onChanged: (value) {
              onChangedValue = value;
            },
          ),
        ),
      ),
    );

    expect(find.text("No. of ${carSlotTypeValues.reverse[carSize]!} slots"), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '5');

    expect(onChangedValue, '5');
  });
}
