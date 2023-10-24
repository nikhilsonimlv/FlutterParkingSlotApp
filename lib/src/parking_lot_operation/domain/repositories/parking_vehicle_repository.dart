import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';

abstract class ParkingVehicleRepository {
  const ParkingVehicleRepository();

  ResultingFuture<ParkingVehicleEntity> insertParkingSlot({required Vehicle vehicle});

  ResultingFuture<ParkingVehicleEntity> getParkedVehicleInfoBySLodId({required String carSlotId});

  ResultingFuture<int> freeParkingSlot({required String slotId});

  ResultingFuture<ParkingSlotEntity> getAvailableParkingSlotByCarSize({required CarSize carSize});

  ResultingFuture<List<ParkingVehicleEntity>> getAllParkedVehicleSlots();
}
