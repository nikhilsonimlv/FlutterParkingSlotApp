import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';

class GetParkedVehicleInfoBySlotIdUseCase extends UseCaseWithParameter<ParkingVehicleEntity, String> {
  final ParkingVehicleRepository _parkingVehicleRepository;

  const GetParkedVehicleInfoBySlotIdUseCase(this._parkingVehicleRepository);

  @override
  ResultingFuture<ParkingVehicleEntity> call(String parameters) {
    return _parkingVehicleRepository.getParkedVehicleInfoBySLodId(carSlotId: parameters);
  }
}
