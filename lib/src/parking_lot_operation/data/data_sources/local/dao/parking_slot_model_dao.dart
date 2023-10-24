import 'package:floor/floor.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

@dao
abstract class ParkingSlotModelDao {
  @Query('SELECT * FROM ParkingSlotTable')
  Future<List<ParkingSlotEntity>?> findAllParkingSlots();

  @insert
  Future<List<int>> insertParkingSlots(List<ParkingSlotEntity> parkingSlots);

  @Query('SELECT * FROM ParkingSlotTable WHERE isOccupied = 0 AND slotSize = :slotSize LIMIT 1')
  Future<ParkingSlotEntity?> getAvailableParkingSlotByCarSize(String slotSize);

  @Query('SELECT COUNT(*) FROM ParkingSlotTable WHERE slotSize = :slotSize ')
  Future<int?> getNumberOfParkingSlotByCarSize(String slotSize);

  @Query('SELECT COUNT(*) FROM ParkingSlotTable WHERE isOccupied = 0 AND slotSize = :slotSize ')
  Future<int?> getNumberOfAvailableParkingSlotByCarSize(String slotSize);

  @delete
  Future<void> deleteParkingSlotItem(ParkingSlotEntity parkingSlot);

  @update
  Future<void> updateParkingSlotItem(ParkingSlotEntity parkingSlot);

  @Query('UPDATE ParkingSlotTable SET isOccupied = 1 WHERE slot_id = :slotId')
  Future<int?> updateAsOccupied(String slotId);

  @Query('UPDATE ParkingSlotTable SET isOccupied = 0 WHERE slot_id = :slotId')
  Future<int?> updateAsFree(String slotId);

  @Query('SELECT COUNT(*) FROM ParkingSlotTable WHERE slotSize = :slotSize AND isOccupied = 0')
  Future<int?> countFreeCarSlotsBySize(String slotSize);
}
