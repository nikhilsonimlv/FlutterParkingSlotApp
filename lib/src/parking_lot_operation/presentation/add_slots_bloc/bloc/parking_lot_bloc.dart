import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/add_parking_slot_info_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_available_parking_slot_by_car_size_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_parking_slots_by_car_size_use_case.dart';

part 'parking_lot_event.dart';
part 'parking_lot_state.dart';

class ParkingLotBloc extends Bloc<ParkingLotEvent, ParkingLotState> {
  final AddParkingSlotInfoUseCase _addParkingSlotInfoUseCase;
  final GetAvailableParkingSlotByCarSizeUseCase _getAvailableParkingSlotByCarSizeUseCase;
  final GetParkingSlotsByCarSizeUseCase _getParkingSlotsByCarSizeUseCase;

  ParkingLotBloc({
    required GetAvailableParkingSlotByCarSizeUseCase getAvailableParkingSlotByCarSizeUseCase,
    required AddParkingSlotInfoUseCase addParkingSlotInfoUseCase,
    required GetParkingSlotsByCarSizeUseCase getParkingSlotsByCarSizeUseCase,
  })  : _addParkingSlotInfoUseCase = addParkingSlotInfoUseCase,
        _getAvailableParkingSlotByCarSizeUseCase = getAvailableParkingSlotByCarSizeUseCase,
        _getParkingSlotsByCarSizeUseCase = getParkingSlotsByCarSizeUseCase,
        super(
          const ParkingLotState(),
        ) {
    on<GetParkingSlotsByCarSizeEvent>(_getParkingSlotHandler);
    on<AddParkingSlotsEvent>(_addParkingSlotsHandler);
    on<TabChangeEvent>(_tabChangeHandler);
  }

  FutureOr<void> _getParkingSlotHandler(GetParkingSlotsByCarSizeEvent event, Emitter<ParkingLotState> emit) async {
    emit(state.copyWith(parkingSlotStatus: ParkingSlotStatus.gettingParkingSlotsByCarSize));

    final totNoOfSmallSlots = await _getParkingSlotsByCarSizeUseCase(CarSize.small);
    final totNoOfMediumSlots = await _getParkingSlotsByCarSizeUseCase(CarSize.medium);
    final totNoOfLargeSlots = await _getParkingSlotsByCarSizeUseCase(CarSize.large);
    final totNoOfExtraLargeSlots = await _getParkingSlotsByCarSizeUseCase(CarSize.xl);

    final totNoOfOccupiedSmallSlots = await _getAvailableParkingSlotByCarSizeUseCase(CarSize.small);
    final totNoOfOccupiedMediumSlots = await _getAvailableParkingSlotByCarSizeUseCase(CarSize.medium);
    final totNoOfOccupiedLargeSlots = await _getAvailableParkingSlotByCarSizeUseCase(CarSize.large);
    final totNoOfOccupiedExtraLargeSlots = await _getAvailableParkingSlotByCarSizeUseCase(CarSize.xl);

    emit(state.copyWith(
      parkingSlotStatus: ParkingSlotStatus.parkingSlotsLoaded,
      totNoOfSmallSlots: totNoOfSmallSlots.fold((failure) => 0, (slots) => slots),
      totNoOfMediumSlots: totNoOfMediumSlots.fold((failure) => 0, (slots) => slots),
      totNoOfLargeSlots: totNoOfLargeSlots.fold((failure) => 0, (slots) => slots),
      totNoOfExtraLargeSlots: totNoOfExtraLargeSlots.fold((failure) => 0, (slots) => slots),
      totNoOfOccupiedSmallSlots: totNoOfOccupiedSmallSlots.fold((failure) => 0, (slots) => slots),
      totNoOfOccupiedMediumSlots: totNoOfOccupiedMediumSlots.fold((failure) => 0, (slots) => slots),
      totNoOfOccupiedLargeSlots: totNoOfOccupiedLargeSlots.fold((failure) => 0, (slots) => slots),
      totNoOfOccupiedExtraLargeSlots: totNoOfOccupiedExtraLargeSlots.fold((failure) => 0, (slots) => slots),
    ));
  }

  FutureOr<void> _addParkingSlotsHandler(AddParkingSlotsEvent event, Emitter<ParkingLotState> emit) async {
    emit(state.copyWith(parkingSlotStatus: ParkingSlotStatus.addingParkingSlots));

    final result = await _addParkingSlotInfoUseCase(ParkingSlotParams(
      floorNumber: event.floorNumber,
      numberOfSmallSlots: event.numberOfSmallSlots,
      numberOfLargeSlots: event.numberOfLargeSlots,
      numberOfMediumSlots: event.numberOfMediumSlots,
      numberOfExtraLargeSlots: event.numberOfExtraLargeSlots,
    ));
    result.fold(
      (failure) => emit(
        state.copyWith(parkingSlotStatus: ParkingSlotStatus.parkingSlotError, errorMessage: failure.errorMessage),
      ),
      (parkingSlots) => emit(
        state.copyWith(parkingSlotStatus: ParkingSlotStatus.parkingSlotsAdded, floorNumber: event.floorNumber),
      ),
    );
  }

  FutureOr<void> _tabChangeHandler(TabChangeEvent event, Emitter<ParkingLotState> emit) {
    emit(state.copyWith(pageIndex: event.tabIndex));
  }
}
