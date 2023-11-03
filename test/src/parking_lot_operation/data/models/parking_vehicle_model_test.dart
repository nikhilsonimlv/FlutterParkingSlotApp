import 'package:parkingslot/src/parking_lot_operation/data/models/parking_vehicle_model.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:test/test.dart';

void main() {
  group('ParkingVehicleModel Tests', () {
    test('should be a subclass of parking_vehicle_entity', () {
      // Arrange

      const int id = 1;
      const String carSize = 'small';
      const String carNumber = 'ABC123';
      const String floorNumber = 'A';
      const String carSlotId = "100";
      const String allocatedSlotType = 'small';
      const bool isParked = true;

      // Act
      const parkingVehicleModel = ParkingVehicleModel(
        id: id,
        carSize: carSize,
        carNumber: carNumber,
        floorNumber: floorNumber,
        carSlotId: carSlotId,
        allocatedSlotType: allocatedSlotType,
        isParked: isParked,
      );

      //Assert
      expect(parkingVehicleModel, isA<ParkingVehicleEntity>());
    });
    test('fromEntity should create a model from an entity', () {
      // Arrange
      const entity = ParkingVehicleEntity(
        id: 1,
        carSize: 'small',
        carNumber: 'ABC123',
        floorNumber: 'A',
        carSlotId: "100",
        allocatedSlotType: 'small',
        isParked: true,
      );

      // Act
      final model = ParkingVehicleModel.fromEntity(entity);

      // Assert
      expect(model, isA<ParkingVehicleModel>());
      expect(model.id, 1);
      expect(model.carSize, 'small');
      expect(model.carNumber, 'ABC123');
      expect(model.floorNumber, 'A');
      expect(model.carSlotId, "100");
      expect(model.allocatedSlotType, 'small');
      expect(model.isParked, true);
    });
  });
}
