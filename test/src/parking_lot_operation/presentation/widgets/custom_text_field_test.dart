import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/custom_text_field.dart';

void main() {
  testWidgets('CustomTextField widget test', (WidgetTester tester) async {
    final textEditingController = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomTextField(
            label: 'Custom Label',
            controller: textEditingController,
            keyboardType: TextInputType.text,
          ),
        ),
      ),
    );

    expect(find.text('Custom Label'), findsOneWidget);

    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Test Text');
    expect(textEditingController.text, 'Test Text');
  });
}
