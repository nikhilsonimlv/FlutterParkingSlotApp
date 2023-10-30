import 'package:parkingslot/src/core/utils/util.dart';

class ParkingLotParams {
  final int id;
  final String name;
  final String location;
  final int totalSlots;
  final Map<String, int> slotSizes;
  final List<ParkingFloorParams> floors;

  const ParkingLotParams.empty() : this(id: 1, name: "name.empty", location: "Rajasthan", totalSlots: 100, floors: const [], slotSizes: const {});

  const ParkingLotParams({
    required this.name,
    required this.location,
    required this.totalSlots,
    required this.slotSizes,
    required this.floors,
    required this.id,
  });
}

class ParkingFloorParams {
  final int floorNumber;
  final Map<String, int> slots;

  const ParkingFloorParams.empty()
      : this(
          floorNumber: 2,
          slots: const {},
        );

  const ParkingFloorParams({
    required this.floorNumber,
    required this.slots,
  });
}

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
}

class Vehicle {
  final CarSize carSize;
  final String numberPlate;

  Vehicle({
    required this.carSize,
    required this.numberPlate,
  });
}
