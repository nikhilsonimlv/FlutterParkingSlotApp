import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/util.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/add_parking_slot_info_use_case.dart';
import 'package:test/test.dart';

import 'get_parking_slots_by_car_size_use_case_test.dart';

void main() {
  group('AddParkingSlotInfoUseCase', () {
    final mockParkingLotRepository = MockParkingLotRepository();
    final addParkingSlotInfoUseCase = AddParkingSlotInfoUseCase(mockParkingLotRepository);

    test('should add parking slots successfully', () async {
      // Given
      final parkingSlotParams = ParkingSlotParams(
        numberOfSmallSlots: 1,
        numberOfMediumSlots: 1,
        numberOfLargeSlots: 1,
        numberOfExtraLargeSlots: 1,
        floorNumber: "A",
        existingNumberOfSlotsInFloor: 0,
      );

      // When
      when(() {
        return mockParkingLotRepository.addParkingSlots(listOfParkingSlotEntity: any(named: "listOfParkingSlotEntity"));
      }).thenAnswer((_) async {
        final parkingSlots = _.namedArguments[#listOfParkingSlotEntity] as List<ParkingSlotEntity>;
        int smallCount = 0;
        int largeCount = 0;
        int xlCount = 0;
        int mediumCount = 0;

        for (var object in parkingSlots) {
          if (object.slotSize == "Small") {
            smallCount++;
          } else if (object.slotSize == "Large") {
            largeCount++;
          } else if (object.slotSize == "XL") {
            xlCount++;
          } else if (object.slotSize == "Medium") {
            mediumCount++;
          }
        }
        return Right([smallCount, largeCount, xlCount, mediumCount]);
      });

      final result = await addParkingSlotInfoUseCase(parkingSlotParams);

      result.fold(
        (l) {
          expect(result, const Left(LocalFailure(errorMessage: 'Error', statusCode: 500)));
        },
        (r) {
          expect(r.length,
              parkingSlotParams.numberOfSmallSlots + parkingSlotParams.numberOfLargeSlots + parkingSlotParams.numberOfMediumSlots + parkingSlotParams.numberOfExtraLargeSlots);
        },
      );

      // Then
      verify(() => mockParkingLotRepository.addParkingSlots(listOfParkingSlotEntity: any(named: "listOfParkingSlotEntity")));
    });

    test('should return an error if adding parking slots fails', () async {
      // Given
      final parkingSlotParams = ParkingSlotParams(
        numberOfSmallSlots: 1,
        numberOfMediumSlots: 1,
        numberOfLargeSlots: 1,
        numberOfExtraLargeSlots: 1,
        floorNumber: "A",
        existingNumberOfSlotsInFloor: 0,
      );

      // When
      when(() {
        return mockParkingLotRepository.addParkingSlots(listOfParkingSlotEntity: any(named: "listOfParkingSlotEntity"));
      }).thenAnswer((_) async => const Left(LocalFailure(errorMessage: 'Error', statusCode: 500)));

      final result = await addParkingSlotInfoUseCase(parkingSlotParams);
      var t = result.asLeft();
      // Then
      expect(t, const LocalFailure(errorMessage: 'Error', statusCode: 500));
      expect(t.props, ['Error', 500]);
      verify(() => mockParkingLotRepository.addParkingSlots(listOfParkingSlotEntity: any(named: 'listOfParkingSlotEntity')));
    });
  });
}
