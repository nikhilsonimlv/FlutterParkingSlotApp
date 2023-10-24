import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';

class FreeParkingSlotUseCase extends UseCaseWithParameter<int, ParkingVehicleEntity> {
  final ParkingVehicleRepository _parkingVehicleRepository;

  const FreeParkingSlotUseCase(this._parkingVehicleRepository);

  @override
  ResultingFuture<int> call(ParkingVehicleEntity parameters) {
    return _parkingVehicleRepository.freeParkingSlot(slotId: parameters.carSlotId!);
  }
}
