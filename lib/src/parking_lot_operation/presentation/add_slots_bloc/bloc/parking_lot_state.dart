part of 'parking_lot_bloc.dart';

enum ParkingSlotStatus { parkingSlotInitial, parkingSlotsLoaded, parkingSlotsAdded, addingParkingSlots, gettingParkingSlotsByCarSize, parkingSlotError }

class ParkingLotState extends Equatable {
  final int totNoOfSmallSlots;
  final int totNoOfOccupiedSmallSlots;
  final int totNoOfLargeSlots;
  final int totNoOfOccupiedLargeSlots;
  final int totNoOfMediumSlots;
  final int totNoOfOccupiedMediumSlots;
  final int totNoOfExtraLargeSlots;
  final int totNoOfOccupiedExtraLargeSlots;
  final ParkingSlotStatus parkingSlotStatus;
  final String errorTitle;
  final String errorMessage;
  final int pageIndex;
  final int floorNumber;

  const ParkingLotState({
    this.totNoOfSmallSlots = 0,
    this.totNoOfOccupiedSmallSlots = 0,
    this.totNoOfLargeSlots = 0,
    this.totNoOfOccupiedLargeSlots = 0,
    this.totNoOfMediumSlots = 0,
    this.totNoOfOccupiedMediumSlots = 0,
    this.totNoOfExtraLargeSlots = 0,
    this.totNoOfOccupiedExtraLargeSlots = 0,
    this.parkingSlotStatus = ParkingSlotStatus.parkingSlotInitial,
    this.errorTitle = '',
    this.errorMessage = '',
    this.pageIndex = 0,
    this.floorNumber = 1,
  });

  ParkingLotState copyWith({
    int? totNoOfSmallSlots,
    int? totNoOfLargeSlots,
    int? totNoOfMediumSlots,
    int? totNoOfExtraLargeSlots,
    int? totNoOfOccupiedSmallSlots,
    int? totNoOfOccupiedLargeSlots,
    int? totNoOfOccupiedMediumSlots,
    int? totNoOfOccupiedExtraLargeSlots,
    ParkingSlotStatus? parkingSlotStatus,
    String? errorTitle,
    String? errorMessage,
    int? pageIndex,
    int? floorNumber,
  }) {
    return ParkingLotState(
      totNoOfSmallSlots: totNoOfSmallSlots ?? this.totNoOfSmallSlots,
      totNoOfLargeSlots: totNoOfLargeSlots ?? this.totNoOfLargeSlots,
      totNoOfMediumSlots: totNoOfMediumSlots ?? this.totNoOfMediumSlots,
      totNoOfExtraLargeSlots: totNoOfExtraLargeSlots ?? this.totNoOfExtraLargeSlots,
      totNoOfOccupiedSmallSlots: totNoOfOccupiedSmallSlots ?? this.totNoOfOccupiedSmallSlots,
      totNoOfOccupiedLargeSlots: totNoOfOccupiedLargeSlots ?? this.totNoOfOccupiedLargeSlots,
      totNoOfOccupiedMediumSlots: totNoOfOccupiedMediumSlots ?? this.totNoOfOccupiedMediumSlots,
      totNoOfOccupiedExtraLargeSlots: totNoOfOccupiedExtraLargeSlots ?? this.totNoOfOccupiedExtraLargeSlots,
      parkingSlotStatus: parkingSlotStatus ?? this.parkingSlotStatus,
      errorTitle: errorTitle ?? this.errorTitle,
      errorMessage: errorMessage ?? this.errorMessage,
      pageIndex: pageIndex ?? this.pageIndex,
      floorNumber: floorNumber ?? this.floorNumber,
    );
  }

  @override
  List<Object> get props => [
        totNoOfSmallSlots,
        totNoOfLargeSlots,
        totNoOfMediumSlots,
        totNoOfExtraLargeSlots,
        totNoOfOccupiedSmallSlots,
        totNoOfOccupiedLargeSlots,
        totNoOfOccupiedMediumSlots,
        totNoOfOccupiedExtraLargeSlots,
        parkingSlotStatus,
        errorTitle,
        errorMessage,
        pageIndex,
        floorNumber,
      ];
}
