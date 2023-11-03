import 'package:dartz/dartz.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/parking_lot_local_data_sources.dart';
import 'package:parkingslot/src/parking_lot_operation/data/models/parking_slot_model.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';

class ParkingLotRepositoryImpl implements ParkingLotRepository {
  final ParkingLotLocalDataSource _parkingLotLocalDataSource;

  const ParkingLotRepositoryImpl(this._parkingLotLocalDataSource);

  @override
  ResultingFuture<List<int>> addParkingSlots({required List<ParkingSlotEntity> listOfParkingSlotEntity}) async {
    try {
      var value = await _parkingLotLocalDataSource.addParkingSlot(listParkingSlotModel: ParkingSlotModel.convertEntityListToModelList(listOfParkingSlotEntity));
      return Right(value);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<int> getNumberOfParkingSlotsByCarSize({required CarSize carSize}) async {
    try {
      var value = await _parkingLotLocalDataSource.getNumberOfParkingSlotByCarSize(carSize: carSize);
      return Right(value ?? 0);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<int> getNumberOfAvailableParkingSlotsByCarSize({required CarSize carSize}) async {
    try {
      var value = await _parkingLotLocalDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: carSize);
      return Right(value ?? 0);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<int> getNumberOfParkingSlotsByFloorName({required String floorName}) async {
    try {
      var value = await _parkingLotLocalDataSource.getNumberOfSlotsByFloorName(floorName: floorName);
      return Right(value ?? 0);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }
}
