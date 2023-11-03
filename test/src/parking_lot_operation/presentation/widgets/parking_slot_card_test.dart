import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/core/utils/constants.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/info_row.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/parking_slot_card.dart';

void main() {
  late ParkingVehicleEntity mockParkingVehicle;
  setUp(() {
    mockParkingVehicle = const ParkingVehicleEntity(
      carSize: 'Small',
      carNumber: 'ABC123',
      floorNumber: 'A',
      bayNumber: 1,
      allocatedSlotType: 'Small',
      isParked: true,
    );
  });
  group('ParkingSlotCard widget', () {
    testWidgets('should be displayed when the widget is built', (WidgetTester tester) async {
      // Given
      final testWidget = MaterialApp(
        home: Scaffold(
          body: ParkingSlotCard(parkingVehicleEntity: mockParkingVehicle, onPressed: () {}),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      expect(find.byType(ParkingSlotCard), findsOneWidget);
    });

    testWidgets('should display the label and value of each InfoRow widget correctly', (WidgetTester tester) async {
      // Given
      final testWidget = MaterialApp(
        home: Scaffold(
          body: ParkingSlotCard(parkingVehicleEntity: mockParkingVehicle, onPressed: () {}),
        ),
      );

      // When
      await tester.pumpWidget(testWidget);

      // Then
      final infoRowList = tester.widgetList<InfoRow>(find.byType(InfoRow));

      expect(infoRowList.elementAt(0).label, 'Car Number:');
      expect(infoRowList.elementAt(0).value, 'ABC123');

      expect(infoRowList.elementAt(1).label, 'Floor Number:');
      expect(infoRowList.elementAt(1).value, 'A');

      expect(infoRowList.elementAt(2).label, 'Bay ID:');
      expect(infoRowList.elementAt(2).value, 'A:1');

      expect(infoRowList.elementAt(3).label, 'Allocated Slot Type:');
      expect(infoRowList.elementAt(3).value, 'Small');

      expect(infoRowList.elementAt(4).label, 'Is Parked:');
      expect(infoRowList.elementAt(4).value, 'Yes');
    });

    testWidgets('should call the onPressed callback when the Free Slot button is tapped', (WidgetTester tester) async {
      // Given
      bool buttonPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ParkingSlotCard(
              parkingVehicleEntity: mockParkingVehicle,
              onPressed: () {
                buttonPressed = true;
              },
            ),
          ),
        ),
      );

      final freeSlotButton = find.text(AppConstant.freeSlot);
      expect(buttonPressed, false);

      await tester.tap(freeSlotButton);
      await tester.pump();
      expect(buttonPressed, true);
    });
  });
}
