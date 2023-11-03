import 'package:parkingslot/src/core/utils/util.dart';

enum CarSize { small, large, medium, xl }

enum NavbarItem { addSlot, parkCar }

final carSlotTypeValues = EnumValues({"Small": CarSize.small, "Large": CarSize.large, "Medium": CarSize.medium, "XL": CarSize.xl});

class ParkingSlotParams {
  final String floorNumber;
  final int numberOfSmallSlots;
  final int numberOfLargeSlots;
  final int numberOfMediumSlots;
  final int numberOfExtraLargeSlots;
  final int existingNumberOfSlotsInFloor;

  ParkingSlotParams({
    required this.floorNumber,
    required this.numberOfSmallSlots,
    required this.numberOfLargeSlots,
    required this.numberOfMediumSlots,
    required this.numberOfExtraLargeSlots,
    required this.existingNumberOfSlotsInFloor,
  });

  ParkingSlotParams.empty()
      : floorNumber = '',
        numberOfSmallSlots = 0,
        numberOfLargeSlots = 0,
        numberOfMediumSlots = 0,
        numberOfExtraLargeSlots = 0,
        existingNumberOfSlotsInFloor = 0;
}

class Vehicle {
  final CarSize carSize;
  final String numberPlate;

  Vehicle({
    required this.carSize,
    required this.numberPlate,
  });
}
