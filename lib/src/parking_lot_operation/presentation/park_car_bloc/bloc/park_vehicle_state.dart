part of 'park_vehicle_bloc.dart';

enum ParkingVehicleStatus {
  parkingVehicleInitial,
  parkingVehicleLoading,
  parkingVehicleAdding,
  parkingVehicleRemoving,
  parkingVehicleAdded,
  gettingAllParkedVehicleSlots,
  allParkedVehicleSlotsLoaded,
  gettingParkedVehicleInfo,
  parkingVehicleError,
  parkingVehicleRemoved,
}

@immutable
class ParkVehicleState extends Equatable {
  final ParkingVehicleStatus parkingVehicleStatus;
  final ParkingVehicleEntity parkingVehicleEntity;
  final List<ParkingVehicleEntity> parkedVehicleList;
  final CarSize carSize;
  final bool updateSlotList;
  final String errorTitle;
  final String errorMessage;

  const ParkVehicleState({
    this.carSize = CarSize.small,
    this.parkingVehicleStatus = ParkingVehicleStatus.parkingVehicleInitial,
    this.parkedVehicleList = const [],
    this.parkingVehicleEntity = const ParkingVehicleEntity(),
    this.updateSlotList = false,
    this.errorTitle = '',
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        parkingVehicleStatus,
        errorTitle,
        errorMessage,
        parkingVehicleEntity,
        parkedVehicleList,
        carSize,
      ];

  ParkVehicleState copyWith({
    ParkingVehicleStatus? parkingVehicleStatus,
    CarSize? carSize,
    ParkingVehicleEntity? parkingVehicleEntity,
    List<ParkingVehicleEntity>? parkedVehicleList,
    bool? updateSlotList,
    String? errorTitle,
    String? errorMessage,
  }) {
    return ParkVehicleState(
      parkingVehicleStatus: parkingVehicleStatus ?? this.parkingVehicleStatus,
      carSize: carSize ?? this.carSize,
      parkingVehicleEntity: parkingVehicleEntity ?? this.parkingVehicleEntity,
      parkedVehicleList: parkedVehicleList ?? this.parkedVehicleList,
      updateSlotList: updateSlotList ?? this.updateSlotList,
      errorTitle: errorTitle ?? this.errorTitle,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
