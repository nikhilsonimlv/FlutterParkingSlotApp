import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';

class GetAvailableParkingSlotByCarSizeUseCase extends UseCaseWithParameter<int, CarSize> {
  final ParkingLotRepository _parkingLotRepository;

  GetAvailableParkingSlotByCarSizeUseCase(this._parkingLotRepository);

  @override
  ResultingFuture<int> call(CarSize parameters) {
    return _parkingLotRepository.getNumberOfAvailableParkingSlotsByCarSize(carSize: parameters);
  }
}
