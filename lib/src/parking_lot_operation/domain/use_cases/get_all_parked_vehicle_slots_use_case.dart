import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/services/injection_container.dart';
import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:uuid/uuid.dart';

class GetAllParkedVehicleSlotsUseCase extends UseCaseWithOutParameter<List<ParkingVehicleEntity>> {
  final ParkingVehicleRepository _parkingVehicleRepository;

  GetAllParkedVehicleSlotsUseCase(this._parkingVehicleRepository);

  @override
  ResultingFuture<List<ParkingVehicleEntity>> call() {
    return _parkingVehicleRepository.getAllParkedVehicleSlots();
  }
}
