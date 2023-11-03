import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';

class ParkingVehicleModel extends ParkingVehicleEntity {
  const ParkingVehicleModel({
    required super.id,
    required super.carSize,
    required super.carNumber,
    required super.floorNumber,
    required super.carSlotId,
    required super.allocatedSlotType,
    required super.isParked,
  });

  factory ParkingVehicleModel.fromEntity(ParkingVehicleEntity parkingVehicleEntity) {
    return ParkingVehicleModel(
      id: parkingVehicleEntity.id,
      carSize: parkingVehicleEntity.carSize,
      carNumber: parkingVehicleEntity.carNumber,
      floorNumber: parkingVehicleEntity.floorNumber,
      carSlotId: parkingVehicleEntity.carSlotId,
      allocatedSlotType: parkingVehicleEntity.allocatedSlotType,
      isParked: parkingVehicleEntity.isParked,
    );
  }
}
