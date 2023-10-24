import 'package:dartz/dartz.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/parking_lot_local_data_sources.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';

class ParkingVehicleRepositoryImpl implements ParkingVehicleRepository {
  final ParkingLotLocalDataSource _parkingLotLocalDataSource;

  const ParkingVehicleRepositoryImpl(this._parkingLotLocalDataSource);

  @override
  ResultingFuture<int> freeParkingSlot({required String slotId}) async {
    try {
      final result = await _parkingLotLocalDataSource.deleteVehicleBySlotId(carSlotId: slotId).then(
            (value) => _parkingLotLocalDataSource.updateAsFree(
              slotId: slotId,
            ),
          );
      return Right(result!);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<ParkingSlotEntity> getAvailableParkingSlotByCarSize({required CarSize carSize}) async {
    try {
      final result = await _parkingLotLocalDataSource.getAvailableParkingSlotByCarSize(carSize: carSize);
      return Right(result!);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<ParkingVehicleEntity> insertParkingSlot({required Vehicle vehicle}) async {
    try {
      final carSizes = [CarSize.small, CarSize.medium, CarSize.large, CarSize.xl];
      final currentSizeIndex = carSizes.indexOf(vehicle.carSize);

      if (currentSizeIndex != -1 && currentSizeIndex < carSizes.length - 1) {
        for (int i = currentSizeIndex; i < carSizes.length; i++) {
          final currentCarSize = carSizes[i];
          final result = await _parkingLotLocalDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: currentCarSize);
          if (result != 0) {
            final slotInfo = await _parkingLotLocalDataSource.getAvailableParkingSlotByCarSize(carSize: currentCarSize);
            if (slotInfo != null) {
              final carAdded =
                  await _parkingLotLocalDataSource.insertVehicleParkingSlot(vehicle: vehicle, floor: slotInfo.floor, slotId: slotInfo.slotID, allocatedSlotType: slotInfo.slotSize);
              if (carAdded != 0) {
                await _parkingLotLocalDataSource.updateAsOccupied(slotId: slotInfo.slotID);
                final vehiclePass = await _parkingLotLocalDataSource.getParkedVehicleInfoBySlotId(carSlotId: slotInfo.slotID);
                if (vehiclePass != null) {
                  return Right(vehiclePass);
                }
              }
            }
          } else {
            continue;
          }
        }
        return const Left(LocalFailure(errorMessage: "No SLOT FOUND", statusCode: 500));
      } else {
        return const Left(LocalFailure(errorMessage: "No SLOT FOUND", statusCode: 500));
      }
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
    throw UnimplementedError();
  }

  @override
  ResultingFuture<ParkingVehicleEntity> getParkedVehicleInfoBySLodId({required String carSlotId}) async {
    try {
      final result = await _parkingLotLocalDataSource.getParkedVehicleInfoBySlotId(carSlotId: carSlotId);
      return Right(result!);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }

  @override
  ResultingFuture<List<ParkingVehicleEntity>> getAllParkedVehicleSlots() async{
    try {
      final result = await _parkingLotLocalDataSource.getAllParkedVehicleSlots();
      return Right(result!);
    } on LocalException catch (e) {
      return Left(LocalFailure.fromException(e));
    }
  }
}
