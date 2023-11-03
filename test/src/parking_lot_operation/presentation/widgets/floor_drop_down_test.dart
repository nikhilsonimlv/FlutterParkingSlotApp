import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/floor_drop_down.dart';

void main() {
  testWidgets('FloorDropDown widget test', (WidgetTester tester) async {
    String? selectedFloor;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FloorDropDown(
            onChanged: (floor) {
              selectedFloor = floor;
            },
          ),
        ),
      ),
    );

    expect(selectedFloor ?? 'A', 'A');

    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pump();

    await tester.tap(find.text('C').last);
    await tester.pump();

    expect(selectedFloor, 'C');
  });
}
