import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/custom_elevated_button.dart';

void main() {
  testWidgets('CustomElevatedButton renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomElevatedButton(
            onPressed: () {},
            buttonText: 'Click Me',
          ),
        ),
      ),
    );
    expect(find.byType(CustomElevatedButton), findsOneWidget);
    expect(find.text('Click Me'), findsOneWidget);
    await tester.tap(find.byType(CustomElevatedButton));
    await tester.pump();
  });
}
