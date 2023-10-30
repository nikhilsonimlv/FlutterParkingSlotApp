import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';

class GetNumberOfParkingSlotsByFloorNameUseCase extends UseCaseWithParameter<int, String> {
  final ParkingLotRepository _parkingLotRepository;

  GetNumberOfParkingSlotsByFloorNameUseCase(this._parkingLotRepository);

  @override
  ResultingFuture<int> call(String parameters) {
    return _parkingLotRepository.getNumberOfParkingSlotsByFloorName(floorName: parameters);
  }
}
