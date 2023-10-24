import 'package:floor/floor.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';

@dao
abstract class ParkingVehicleModelDao {
  @insert
  Future<int?> insertParkingSlot(ParkingVehicleEntity parkingVehicleEntity);

  @Query('SELECT * FROM VehicleParkingTable WHERE car_slot_id = :carSlotId LIMIT 1')
  Future<ParkingVehicleEntity?> getParkedVehicleInfoBySlotId(String carSlotId);

  @Query('DELETE FROM VehicleParkingTable WHERE car_slot_id = :carSlotId')
  Future<int?> deleteVehicleBySlotId(String carSlotId);

  @Query('SELECT * FROM VehicleParkingTable')
  Future<List<ParkingVehicleEntity>?> getAllParkedVehicleSlots();
}
