import 'package:flutter_test/flutter_test.dart';
import 'package:parkingslot/src/core/params/params.dart';

void main() {
  group('CarSize enum', () {
    test('should have four valid values', () {
      expect(CarSize.values.length, 4);
    });

    test('should have values small, large, medium, and xl', () {
      expect(CarSize.values, containsAll([CarSize.small, CarSize.large, CarSize.medium, CarSize.xl]));
    });
  });

  group('NavbarItem enum', () {
    test('should have two valid values', () {
      expect(NavbarItem.values.length, 2);
    });

    test('should have values addSlot and parkCar', () {
      expect(NavbarItem.values, containsAll([NavbarItem.addSlot, NavbarItem.parkCar]));
    });
  });

  group('ParkingSlotParams class', () {
    test('should create a valid ParkingSlotParams object', () {
      final parkingSlotParams = ParkingSlotParams(
        floorNumber: "1",
        numberOfSmallSlots: 10,
        numberOfLargeSlots: 5,
        numberOfMediumSlots: 5,
        numberOfExtraLargeSlots: 2,
        existingNumberOfSlotsInFloor: 0,
      );

      expect(parkingSlotParams.floorNumber, "1");
      expect(parkingSlotParams.numberOfSmallSlots, 10);
      expect(parkingSlotParams.numberOfLargeSlots, 5);
      expect(parkingSlotParams.numberOfMediumSlots, 5);
      expect(parkingSlotParams.numberOfExtraLargeSlots, 2);
      expect(parkingSlotParams.existingNumberOfSlotsInFloor, 0);
    });
  });

  group('Vehicle class', () {
    test('should create a valid Vehicle object', () {
      final vehicle = Vehicle(
        carSize: CarSize.small,
        numberPlate: "ABC123",
      );

      expect(vehicle.carSize, CarSize.small);
      expect(vehicle.numberPlate, "ABC123");
    });
  });
}
