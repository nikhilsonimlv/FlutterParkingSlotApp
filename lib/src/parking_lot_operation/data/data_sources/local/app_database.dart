import 'dart:async';

import 'package:floor/floor.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/local/dao/parking_slot_model_dao.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/local/dao/parking_vehicle_model_dao.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 2, entities: [ParkingSlotEntity, ParkingVehicleEntity])
abstract class AppDataBase extends FloorDatabase {
  ParkingSlotModelDao get parkingSlotModelDao;

  ParkingVehicleModelDao get parkingVehicleModelDao;
}
