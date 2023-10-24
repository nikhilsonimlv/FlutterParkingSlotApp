import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

class ParkingSlotModel extends ParkingSlotEntity {
  const ParkingSlotModel({
    required super.id,
    required super.slotID,
    required super.slotSize,
    required super.floor,
    required super.isOccupied,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slotID': slotID,
      'lotID': slotSize,
      'floor': floor,
      'isOccupied': isOccupied,
    };
  }

  factory ParkingSlotModel.fromMap(Map<String, dynamic> map) {
    return ParkingSlotModel(
      id: map['id'] as int,
      slotID: map['slotID'] as String,
      slotSize: map['slotSize'] as String,
      floor: map['floor'] as int,
      isOccupied: map['isOccupied'] as bool,
    );
  }

  ParkingSlotModel copyWith({
    int? id,
    String? slotID,
    int? floor,
    int? sizeID,
    int? slotNumber,
    bool? isOccupied,
  }) {
    return ParkingSlotModel(
      id: id ?? this.id,
      slotID: slotID ?? this.slotID,
      slotSize: slotSize,
      floor: floor ?? this.floor,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }

  factory ParkingSlotModel.fromEntity(ParkingSlotEntity parkingLotEntity) {
    return ParkingSlotModel(
      id: parkingLotEntity.id,
      slotID: parkingLotEntity.slotID,
      slotSize: parkingLotEntity.slotSize,
      floor: parkingLotEntity.floor,
      isOccupied: parkingLotEntity.isOccupied,
    );
  }

  static List<ParkingSlotModel> convertEntityListToModelList(List<ParkingSlotEntity> entityList) {
    return entityList.map((entity) {
      return ParkingSlotModel(
        id: entity.id,
        slotID: entity.slotID,
        slotSize: entity.slotSize,
        floor: entity.floor,
        isOccupied: entity.isOccupied,
      );
    }).toList();
  }
}
