part of 'park_vehicle_bloc.dart';

@immutable
abstract class ParkVehicleEvent  {
  const ParkVehicleEvent();
}

class CarSizeSelectEvent extends ParkVehicleEvent {
  final CarSize carSize;

  const CarSizeSelectEvent({required this.carSize});
}

class SubmitCarSizeEvent extends ParkVehicleEvent {
  final CarSize carSize;

  const SubmitCarSizeEvent({required this.carSize});
}

class SubmitFreeSlotEvent extends ParkVehicleEvent {
  final ParkingVehicleEntity parkingVehicleEntity;
  const SubmitFreeSlotEvent({required this.parkingVehicleEntity});
}

class GetAllParkedVehicleSlotsEvent extends ParkVehicleEvent {
  const GetAllParkedVehicleSlotsEvent();
}
