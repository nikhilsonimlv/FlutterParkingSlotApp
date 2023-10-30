import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/free_parking_slot_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_all_parked_vehicle_slots_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/insert_parking_slot_use_case.dart';

part 'park_vehicle_event.dart';

part 'park_vehicle_state.dart';

class ParkVehicleBloc extends Bloc<ParkVehicleEvent, ParkVehicleState> {
  final InsertParkingSlotUseCase _insertParkingSlotUseCase;
  final FreeParkingSlotUseCase _freeParkingSlotUseCase;
  final GetAllParkedVehicleSlotsUseCase _getAllParkedVehicleSlotsUseCase;

  ParkVehicleBloc({
    required InsertParkingSlotUseCase insertParkingSlotUseCase,
    required FreeParkingSlotUseCase freeParkingSlotUseCase,
    required GetAllParkedVehicleSlotsUseCase getAllParkedVehicleSlotsUseCase,
  })  : _insertParkingSlotUseCase = insertParkingSlotUseCase,
        _freeParkingSlotUseCase = freeParkingSlotUseCase,
        _getAllParkedVehicleSlotsUseCase = getAllParkedVehicleSlotsUseCase,
        super(
          const ParkVehicleState(),
        ) {
    on<CarSizeSelectEvent>(_carSizeHandler);
    on<SubmitCarSizeEvent>(_carSizeSubmitHandler);
    on<SubmitFreeSlotEvent>(_freeSlotSubmitHandler);
    on<GetAllParkedVehicleSlotsEvent>(_getAllParkedVehicleSlotsHandler);
  }

  FutureOr<void> _carSizeHandler(CarSizeSelectEvent event, Emitter<ParkVehicleState> emit) {
    emit(state.copyWith(carSize: event.carSize));
  }

  FutureOr<void> _carSizeSubmitHandler(SubmitCarSizeEvent event, Emitter<ParkVehicleState> emit) async {
    Random random = Random();
    emit(state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleAdding, updateSlotList: false));
    final parkingVehicleSlot = await _insertParkingSlotUseCase(Vehicle(carSize: event.carSize, numberPlate: "KA-${random.nextInt(10000000)}"));
    parkingVehicleSlot.fold(
      (failure) => emit(
        state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: failure.errorMessage, updateSlotList: false),
      ),
      (parkingVehicleSlot) {
        emit(
          state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleAdded, parkingVehicleEntity: parkingVehicleSlot, updateSlotList: true),
        );
      },
    );
  }

  FutureOr<void> _freeSlotSubmitHandler(SubmitFreeSlotEvent event, Emitter<ParkVehicleState> emit) async {
    emit(state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleRemoving, updateSlotList: false));
    final parkingVehicleSlot = await _freeParkingSlotUseCase(event.parkingVehicleEntity);
    parkingVehicleSlot.fold(
      (failure) => emit(
        state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: failure.errorMessage),
      ),
      (parkingVehicleSlot) => emit(
        state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleRemoved, updateSlotList: true),
      ),
    );
  }

  FutureOr<void> _getAllParkedVehicleSlotsHandler(GetAllParkedVehicleSlotsEvent event, Emitter<ParkVehicleState> emit) async {
    emit(state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.gettingAllParkedVehicleSlots, updateSlotList: false));
    final parkingVehicleSlot = await _getAllParkedVehicleSlotsUseCase();
    parkingVehicleSlot.fold(
      (failure) => emit(
        state.copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: failure.errorMessage),
      ),
      (parkedVehicleList) => emit(
        state.copyWith(parkedVehicleList: parkedVehicleList.reversed.toList(), parkingVehicleStatus: ParkingVehicleStatus.allParkedVehicleSlotsLoaded, updateSlotList: false),
      ),
    );
  }
}
