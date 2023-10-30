import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

class ParkingSlotModel extends ParkingSlotEntity {
  const ParkingSlotModel({
    required super.id,
    required super.slotID,
    required super.slotSize,
    required super.floorName,
    required super.customBayId,
    required super.isOccupied,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'slotID': slotID,
      'lotID': slotSize,
      'floor': floorName,
      'customBayId': customBayId,
      'isOccupied': isOccupied,
    };
  }

  factory ParkingSlotModel.fromMap(Map<String, dynamic> map) {
    return ParkingSlotModel(
      id: map['id'] as int,
      slotID: map['slotID'] as String,
      slotSize: map['slotSize'] as String,
      floorName: map['floor'] as String,
      customBayId: map['customBayId'] as int,
      isOccupied: map['isOccupied'] as bool,
    );
  }

  ParkingSlotModel copyWith({
    int? id,
    String? slotID,
    String? slotSize,
    String? floorName,
    int? customBayId,
    bool? isOccupied,
  }) {
    return ParkingSlotModel(
      id: id ?? this.id,
      slotID: slotID ?? this.slotID,
      slotSize: slotSize ?? this.slotSize,
      floorName: floorName ?? this.floorName,
      customBayId: customBayId ?? this.customBayId,
      isOccupied: isOccupied ?? this.isOccupied,
    );
  }

  factory ParkingSlotModel.fromEntity(ParkingSlotEntity parkingLotEntity) {
    return ParkingSlotModel(
      id: parkingLotEntity.id,
      slotID: parkingLotEntity.slotID,
      slotSize: parkingLotEntity.slotSize,
      floorName: parkingLotEntity.floorName,
      customBayId: parkingLotEntity.customBayId,
      isOccupied: parkingLotEntity.isOccupied,
    );
  }

  static List<ParkingSlotModel> convertEntityListToModelList(List<ParkingSlotEntity> entityList) {
    return entityList.map((entity) {
      return ParkingSlotModel(
        id: entity.id,
        slotID: entity.slotID,
        slotSize: entity.slotSize,
        floorName: entity.floorName,
        customBayId: entity.customBayId,
        isOccupied: entity.isOccupied,
      );
    }).toList();
  }
}
