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
