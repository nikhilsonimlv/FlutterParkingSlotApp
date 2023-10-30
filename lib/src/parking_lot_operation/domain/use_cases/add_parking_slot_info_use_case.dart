import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/services/injection_container.dart';
import 'package:parkingslot/src/core/use_case/use_case.dart';
import 'package:parkingslot/src/core/utils/app_typedef.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:uuid/uuid.dart';

class AddParkingSlotInfoUseCase extends UseCaseWithParameter<List<int>, ParkingSlotParams> {
  final ParkingLotRepository _parkingLotRepository;

  AddParkingSlotInfoUseCase(this._parkingLotRepository);

  @override
  ResultingFuture<List<int>> call(ParkingSlotParams parameters) async {
    final int smallSlots = parameters.numberOfSmallSlots;
    final int largeSlots = parameters.numberOfLargeSlots;
    final int mediumSlots = parameters.numberOfMediumSlots;
    final int extraLargeSlots = parameters.numberOfExtraLargeSlots;
    final totalNumberOfSlots = parameters.numberOfExtraLargeSlots + parameters.numberOfLargeSlots + parameters.numberOfMediumSlots + parameters.numberOfSmallSlots;
    final floor = parameters.floorNumber;

    final generatedParkingSlots = <ParkingSlotEntity>[];
    var small = 0;
    var large = 0;
    var medium = 0;
    var extraLarge = 0;
    int currentCounter = parameters.existingNumberOfSlotsInFloor;

    while (generatedParkingSlots.length < totalNumberOfSlots) {
      var customSLotId = sl<Uuid>().v4();
      if (small < smallSlots) {
        generatedParkingSlots.add(
          ParkingSlotEntity(
            isOccupied: false,
            floorName: floor,
            slotSize: carSlotTypeValues.reverse[CarSize.small]!,
            slotID: "$floor:small:$customSLotId",
            customBayId: ++currentCounter,
          ),
        );
        small++;
      } else if (large < largeSlots) {
        generatedParkingSlots.add(
          ParkingSlotEntity(
            isOccupied: false,
            floorName: floor,
            slotSize: carSlotTypeValues.reverse[CarSize.large]!,
            slotID: "$floor:large:$customSLotId",
            customBayId: ++currentCounter,
          ),
        );
        large++;
      } else if (medium < mediumSlots) {
        generatedParkingSlots.add(
          ParkingSlotEntity(
            isOccupied: false,
            floorName: floor,
            slotSize: carSlotTypeValues.reverse[CarSize.medium]!,
            slotID: "$floor:medium:$customSLotId",
            customBayId: ++currentCounter,
          ),
        );
        medium++;
      } else if (extraLarge < extraLargeSlots) {
        generatedParkingSlots.add(
          ParkingSlotEntity(
            isOccupied: false,
            floorName: floor,
            slotSize: carSlotTypeValues.reverse[CarSize.xl]!,
            slotID: "$floor:xl:$customSLotId",
            customBayId: ++currentCounter,
          ),
        );
        extraLarge++;
      } else {
        break;
      }
    }
    return _parkingLotRepository.addParkingSlots(listOfParkingSlotEntity: generatedParkingSlots);
  }
}
