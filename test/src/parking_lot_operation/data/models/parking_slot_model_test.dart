import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/data/models/parking_slot_model.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:test/test.dart';

void main() {
  group("ParkingSlot model Test", () {
    test('should be a subclass of parking_slot_entity', () {
      // Arrange
      const parkingSlotModel = ParkingSlotModel(
        id: 1,
        slotID: 'A1',
        slotSize: 'small',
        floorName: 'A',
        customBayId: 100,
        isOccupied: false,
      );

      expect(parkingSlotModel, isA<ParkingSlotEntity>());
    });

    test('convertEntityListToModelList should convert a list of entities to a list of models', () {
      // Arrange
      final entityList = [
        ParkingSlotEntity(
          id: 1,
          slotID: "1:small:abcd",
          slotSize: carSlotTypeValues.reverse[CarSize.small]!,
          floorName: "1",
          customBayId: 1,
          isOccupied: false,
        ),
        ParkingSlotEntity(
          id: 2,
          slotID: "1:medium:efgh",
          slotSize: carSlotTypeValues.reverse[CarSize.medium]!,
          floorName: "1",
          customBayId: 2,
          isOccupied: true,
        ),
      ];

      // Act
      final modelList = ParkingSlotModel.convertEntityListToModelList(entityList);

      // Assert
      expect(modelList, isA<List<ParkingSlotModel>>());
      expect(modelList.length, 2);
      expect(modelList[0].id, 1);
      expect(modelList[0].slotID, "1:small:abcd");
      expect(modelList[0].slotSize, carSlotTypeValues.reverse[CarSize.small]);
      expect(modelList[0].floorName, "1");
      expect(modelList[0].customBayId, 1);
      expect(modelList[0].isOccupied, false);
      expect(modelList[1].id, 2);
      expect(modelList[1].slotID, "1:medium:efgh");
      expect(modelList[1].slotSize, carSlotTypeValues.reverse[CarSize.medium]);
      expect(modelList[1].floorName, "1");
      expect(modelList[1].customBayId, 2);
      expect(modelList[1].isOccupied, true);
    });
  });
}
