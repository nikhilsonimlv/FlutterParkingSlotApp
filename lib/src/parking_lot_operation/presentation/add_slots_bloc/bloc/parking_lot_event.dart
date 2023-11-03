part of 'parking_lot_bloc.dart';

abstract class ParkingLotEvent {
  const ParkingLotEvent();
}

class TabChangeEvent extends ParkingLotEvent {
  final int tabIndex;

  const TabChangeEvent({required this.tabIndex});
}

class GetParkingSlotsByCarSizeEvent extends ParkingLotEvent {
  const GetParkingSlotsByCarSizeEvent();
}

class AddParkingSlotsEvent extends ParkingLotEvent {
  final String floorNumber;
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
