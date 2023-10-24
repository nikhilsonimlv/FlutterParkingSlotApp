part of 'parking_lot_bloc.dart';

abstract class ParkingLotEvent extends Equatable {
  const ParkingLotEvent();

  @override
  List<Object> get props => [];
}

class TabChangeEvent extends ParkingLotEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
}

class GetParkingSlotsByCarSizeEvent extends ParkingLotEvent {
  const GetParkingSlotsByCarSizeEvent();
}

class AddParkingSlotsEvent extends ParkingLotEvent {
  final int floorNumber;
  final int numberOfSmallSlots;
  final int numberOfLargeSlots;
  final int numberOfMediumSlots;
  final int numberOfExtraLargeSlots;

  const AddParkingSlotsEvent({
    required this.numberOfSmallSlots,
    required this.numberOfLargeSlots,
    required this.numberOfMediumSlots,
    required this.numberOfExtraLargeSlots,
    required this.floorNumber,
  });
}
