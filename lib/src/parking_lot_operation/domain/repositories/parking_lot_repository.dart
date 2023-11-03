import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

abstract class ParkingLotRepository {

  ResultingFuture<List<int>> addParkingSlots({required List<ParkingSlotEntity> listOfParkingSlotEntity});

  ResultingFuture<int> getNumberOfParkingSlotsByCarSize({required CarSize carSize});

  ResultingFuture<int> getNumberOfParkingSlotsByFloorName({required String floorName});

  ResultingFuture<int> getNumberOfAvailableParkingSlotsByCarSize({required CarSize carSize});
}
