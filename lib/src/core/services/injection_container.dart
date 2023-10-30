import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/local/app_database.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/parking_lot_local_data_sources.dart';
import 'package:parkingslot/src/parking_lot_operation/data/repositories/parking_vehicle_repository_impl.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/add_parking_slot_info_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/free_parking_slot_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_all_parked_vehicle_slots_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_available_parking_slot_by_car_size_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_number_of_parking_slots_by_floor_name_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_parked_vehicle_info_by_slot_id_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_parking_slots_by_car_size_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/insert_parking_slot_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/is_parking_slot_available_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/add_slots_bloc/bloc/parking_lot_bloc.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/park_car_bloc/bloc/park_vehicle_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../parking_lot_operation/data/repositories/parking_lot_repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();

  sl
    //App
    ..registerFactory(() => ParkingLotBloc(
          addParkingSlotInfoUseCase: sl(),
          getAvailableParkingSlotByCarSizeUseCase: sl(),
          getParkingSlotsByCarSizeUseCase: sl(),
          getNumberOfParkingSlotsByFloorNameUseCase: sl(),
        ))
    ..registerFactory(() => ParkVehicleBloc(
          insertParkingSlotUseCase: sl(),
          freeParkingSlotUseCase: sl(),
          getAllParkedVehicleSlotsUseCase: sl(),
        ))
    ..registerFactory(() => const Uuid())
    //Use cases
    ..registerLazySingleton(() => AddParkingSlotInfoUseCase(sl()))
    ..registerLazySingleton(() => FreeParkingSlotUseCase(sl()))
    ..registerLazySingleton(() => GetAvailableParkingSlotByCarSizeUseCase(sl()))
    ..registerLazySingleton(() => GetParkingSlotsByCarSizeUseCase(sl()))
    ..registerLazySingleton(() => IsParkingSlotAvailableUseCase(sl()))
    ..registerLazySingleton(() => InsertParkingSlotUseCase(sl()))
    ..registerLazySingleton(() => GetParkedVehicleInfoBySlotIdUseCase(sl()))
    ..registerLazySingleton(() => GetAllParkedVehicleSlotsUseCase(sl()))
    ..registerLazySingleton(() => GetNumberOfParkingSlotsByFloorNameUseCase(sl()))
    //Repo
    ..registerLazySingleton<ParkingLotRepository>(() => ParkingLotRepositoryImpl(sl()))
    ..registerLazySingleton<ParkingVehicleRepository>(() => ParkingVehicleRepositoryImpl(sl()))
    //Data source
    ..registerLazySingleton<ParkingLotLocalDataSource>(() => ParkingLotLocalDataSourceImpl(sl()))
    //Ext dependencies
    ..registerLazySingleton(http.Client.new)
    //Local Db
    ..registerSingleton<AppDataBase>(database);
}
