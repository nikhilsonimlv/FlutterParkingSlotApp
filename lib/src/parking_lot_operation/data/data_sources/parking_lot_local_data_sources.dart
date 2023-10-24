import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/local/app_database.dart';
import 'package:parkingslot/src/parking_lot_operation/data/models/parking_slot_model.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';

abstract class ParkingLotLocalDataSource {
  Future<List<int>> addParkingSlot({required List<ParkingSlotModel> listParkingSlotModel});

  Future<List<ParkingSlotEntity>?> getParkingSlotInfo();

  Future<ParkingSlotEntity?> getAvailableParkingSlotByCarSize({required CarSize carSize});

  Future<int?> getNumberOfParkingSlotByCarSize({required CarSize carSize});

  Future<int?> getNumberOfAvailableParkingSlotByCarSize({required CarSize carSize});

  Future<int?> insertVehicleParkingSlot({required Vehicle vehicle, required int floor, required String slotId, required String allocatedSlotType});

  Future<int?> updateAsOccupied({required String slotId});

  Future<int?> updateAsFree({required String slotId});

  Future<int?> isParkingSlotAvailable({required Vehicle vehicle});

  Future<int?> deleteVehicleBySlotId({required String carSlotId});

  Future<ParkingVehicleEntity?> getParkedVehicleInfoBySlotId({required String carSlotId});

  Future<List<ParkingVehicleEntity>?> getAllParkedVehicleSlots();
}

class ParkingLotLocalDataSourceImpl implements ParkingLotLocalDataSource {
  final AppDataBase _appDataBase;

  ParkingLotLocalDataSourceImpl(this._appDataBase);

  @override
  Future<List<int>> addParkingSlot({required List<ParkingSlotModel> listParkingSlotModel}) {
    return _appDataBase.parkingSlotModelDao.insertParkingSlots(listParkingSlotModel);
  }

  @override
  Future<List<ParkingSlotEntity>?> getParkingSlotInfo() {
    return _appDataBase.parkingSlotModelDao.findAllParkingSlots();
  }

  @override
  Future<ParkingSlotEntity?> getAvailableParkingSlotByCarSize({required CarSize carSize}) {
    return _appDataBase.parkingSlotModelDao.getAvailableParkingSlotByCarSize(carSlotTypeValues.reverse[carSize]!);
  }

  @override
  Future<int?> updateAsOccupied({required String slotId}) {
    return _appDataBase.parkingSlotModelDao.updateAsOccupied(slotId);
  }

  @override
  Future<int?> updateAsFree({required String slotId}) {
    return _appDataBase.parkingSlotModelDao.updateAsFree(slotId);
  }

  @override
  Future<int?> insertVehicleParkingSlot({required Vehicle vehicle, required int floor, required String slotId, required String allocatedSlotType}) {
    return _appDataBase.parkingVehicleModelDao.insertParkingSlot(ParkingVehicleEntity(
      carSize: carSlotTypeValues.reverse[vehicle.carSize]!,
      carNumber: vehicle.numberPlate,
      floorNumber: floor,
      carSlotId: slotId,
      allocatedSlotType: allocatedSlotType,
      isParked: true,
    ));
  }

  @override
  Future<int?> isParkingSlotAvailable({required Vehicle vehicle}) {
    return _appDataBase.parkingSlotModelDao.countFreeCarSlotsBySize(carSlotTypeValues.reverse[vehicle.carSize]!);
  }

  @override
  Future<int?> getNumberOfParkingSlotByCarSize({required CarSize carSize}) {
    return _appDataBase.parkingSlotModelDao.getNumberOfParkingSlotByCarSize(carSlotTypeValues.reverse[carSize]!);
  }

  @override
  Future<int?> getNumberOfAvailableParkingSlotByCarSize({required CarSize carSize}) {
    return _appDataBase.parkingSlotModelDao.getNumberOfAvailableParkingSlotByCarSize(carSlotTypeValues.reverse[carSize]!);
  }

  @override
  Future<ParkingVehicleEntity?> getParkedVehicleInfoBySlotId({required String carSlotId}) {
    return _appDataBase.parkingVehicleModelDao.getParkedVehicleInfoBySlotId(carSlotId);
  }

  @override
  Future<int?> deleteVehicleBySlotId({required String carSlotId}) {
    return _appDataBase.parkingVehicleModelDao.deleteVehicleBySlotId(carSlotId);
  }

  @override
  Future<List<ParkingVehicleEntity>?> getAllParkedVehicleSlots() {
    return _appDataBase.parkingVehicleModelDao.getAllParkedVehicleSlots();
  }
}
