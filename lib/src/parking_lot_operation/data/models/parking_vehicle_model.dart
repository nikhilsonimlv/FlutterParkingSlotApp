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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carSize': carSize,
      'carNumber': carNumber,
      'floorNumber': floorNumber,
      'slotId': carSlotId,
      'allocatedSlotType': allocatedSlotType,
      'isParked': isParked,
    };
  }

  factory ParkingVehicleModel.fromMap(Map<String, dynamic> map) {
    return ParkingVehicleModel(
      id: map['id'] as int,
      carSize: map['carSize'] as String,
      carNumber: map['carNumber'] as String,
      floorNumber: map['floorNumber'] as String,
      carSlotId: map['slotId'] as String,
      allocatedSlotType: map['allocatedSlotType'] as String,
      isParked: map['isParked'] as bool,
    );
  }

  ParkingVehicleModel copyWith({
    int? id,
    String? carSize,
    String? carNumber,
    String? floorNumber,
    String? carSlotId,
    String? allocatedSlotType,
    bool? isParked,
  }) {
    return ParkingVehicleModel(
      id: id ?? this.id,
      carSize: carSize ?? this.carSize,
      carNumber: carNumber ?? this.carNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      carSlotId: carSlotId ?? this.carSlotId,
      allocatedSlotType: allocatedSlotType ?? this.allocatedSlotType,
      isParked: isParked ?? this.isParked,
    );
  }

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
