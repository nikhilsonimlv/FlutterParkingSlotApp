import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';

class InsertParkingSlotUseCase extends UseCaseWithParameter<ParkingVehicleEntity, Vehicle> {
  final ParkingVehicleRepository _parkingVehicleRepository;

  const InsertParkingSlotUseCase(this._parkingVehicleRepository);

  @override
  ResultingFuture<ParkingVehicleEntity> call(Vehicle parameters) {
    return _parkingVehicleRepository.insertParkingSlot(vehicle: parameters);
  }
}
