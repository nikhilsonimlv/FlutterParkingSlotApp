import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

class IsParkingSlotAvailableUseCase extends UseCaseWithParameter<ParkingSlotEntity, CarSize> {
  final ParkingVehicleRepository _parkingVehicleRepository;

  const IsParkingSlotAvailableUseCase(this._parkingVehicleRepository);

  @override
  ResultingFuture<ParkingSlotEntity> call(CarSize parameters) {
    return _parkingVehicleRepository.getAvailableParkingSlotByCarSize(carSize: parameters);
  }
}
