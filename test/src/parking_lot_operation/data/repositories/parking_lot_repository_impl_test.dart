import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/parking_lot_local_data_sources.dart';
import 'package:parkingslot/src/parking_lot_operation/data/models/parking_slot_model.dart';
import 'package:parkingslot/src/parking_lot_operation/data/repositories/parking_lot_repository_impl.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:test/test.dart';

import '../data_sources/parking_lot_local_data_sources_test.mock.dart';

void main() {
  late ParkingLotLocalDataSource localDataSource;
  late ParkingLotRepositoryImpl repoImpl;
  setUp(() {
    localDataSource = MockParkingLotLocalDataSource();
    repoImpl = ParkingLotRepositoryImpl(localDataSource);
  });

  group("addParkingSlots", () {
    test('addParkingSlots should return Right with a list of integers', () async {
      //Arrange
      final listOfParkingSlotEntity = [
        ParkingSlotEntity(
          id: 1,
          slotID: "1:small:abcd",
          slotSize: carSlotTypeValues.reverse[CarSize.small]!,
          floorName: "1",
          customBayId: 1,
          isOccupied: false,
        ),
        ParkingSlotEntity(
          id: 2,
          slotID: "1:medium:efgh",
          slotSize: carSlotTypeValues.reverse[CarSize.medium]!,
          floorName: "1",
          customBayId: 2,
          isOccupied: true,
        ),
      ];
      final parkingSlots = listOfParkingSlotEntity;
      when(
        () => localDataSource.addParkingSlot(listParkingSlotModel: any(named: "listParkingSlotModel")),
      ).thenAnswer((invocation) async {
        return [1, 1];
      });
      // Act
      final result = await repoImpl.addParkingSlots(listOfParkingSlotEntity: parkingSlots);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals([1, 1]));

      verify(
        () => localDataSource.addParkingSlot(listParkingSlotModel: ParkingSlotModel.convertEntityListToModelList(listOfParkingSlotEntity)),
      ).called(1);

      verifyNoMoreInteractions(localDataSource);
    });

    test('should return a failure if adding parking slots fails', () async {
      // Given
      final mockParkingLotLocalDataSource = MockParkingLotLocalDataSource();
      final parkingLotRepositoryImpl = ParkingLotRepositoryImpl(mockParkingLotLocalDataSource);

      final listOfParkingSlotEntity = [
        ParkingSlotEntity(
          id: 1,
          slotID: "1:small:abcd",
          slotSize: carSlotTypeValues.reverse[CarSize.small]!,
          floorName: '',
          customBayId: 1,
          isOccupied: false,
        ),
        ParkingSlotEntity(
          id: 2,
          slotID: "1:medium:efgh",
          slotSize: carSlotTypeValues.reverse[CarSize.medium]!,
          floorName: '',
          customBayId: 2,
          isOccupied: true,
        ),
      ];

      when(() => mockParkingLotLocalDataSource.addParkingSlot(listParkingSlotModel: any(named: "listParkingSlotModel")))
          .thenThrow(const LocalException.name(message: "Error", statusCode: 500));

      // When
      final result = await parkingLotRepositoryImpl.addParkingSlots(listOfParkingSlotEntity: listOfParkingSlotEntity);

      // Then
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => mockParkingLotLocalDataSource.addParkingSlot(listParkingSlotModel: any(named: "listParkingSlotModel"))).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("getNumberOfParkingSlotsByCarSize", () {
    test('getNumberOfParkingSlotsByCarSize should return Right with int', () async {
      // Arrange
      const carSize = CarSize.small;

      when(
        () => localDataSource.getNumberOfParkingSlotByCarSize(carSize: carSize),
      ).thenAnswer((invocation) async {
        return Future.value(1);
      });
      // Act
      final result = await repoImpl.getNumberOfParkingSlotsByCarSize(carSize: carSize);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(1));

      verify(
        () => localDataSource.getNumberOfParkingSlotByCarSize(carSize: carSize),
      ).called(1);

      verifyNoMoreInteractions(localDataSource);
    });

    test('should return a failure if getNumberOfParkingSlotsByCarSize fails', () async {
      // Arrange
      const carSize = CarSize.medium;
      when(() => localDataSource.getNumberOfParkingSlotByCarSize(carSize: carSize)).thenThrow(const LocalException.name(
        message: "Error",
        statusCode: 500,
      ));

      // Act
      final result = await repoImpl.getNumberOfParkingSlotsByCarSize(carSize: carSize);

      // Assert
      // Then
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getNumberOfParkingSlotByCarSize(carSize: carSize)).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("getNumberOfAvailableParkingSlotsByCarSize", () {
    test('getNumberOfAvailableParkingSlotsByCarSize should return Right with int', () async {
      // Arrange
      const carSize = CarSize.small;

      when(
        () => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: carSize),
      ).thenAnswer((invocation) async {
        return Future.value(1);
      });
      // Act
      final result = await repoImpl.getNumberOfAvailableParkingSlotsByCarSize(carSize: carSize);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(1));

      verify(
        () => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: carSize),
      ).called(1);

      verifyNoMoreInteractions(localDataSource);
    });

    test('should return a failure if getNumberOfAvailableParkingSlotsByCarSize fails', () async {
      // Arrange
      const carSize = CarSize.medium;
      when(() => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: carSize)).thenThrow(const LocalException.name(
        message: "Error",
        statusCode: 500,
      ));

      // Act
      final result = await repoImpl.getNumberOfAvailableParkingSlotsByCarSize(carSize: carSize);

      // Assert
      // Then
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: carSize)).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("getNumberOfParkingSlotsByFloorName", () {
    test('getNumberOfParkingSlotsByFloorName should return Right with int', () async {
      // Arrange
      const floorName = "A";

      when(
        () => localDataSource.getNumberOfSlotsByFloorName(floorName: floorName),
      ).thenAnswer((invocation) async {
        return Future.value(1);
      });
      // Act
      final result = await repoImpl.getNumberOfParkingSlotsByFloorName(floorName: floorName);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(1));

      verify(
        () => localDataSource.getNumberOfSlotsByFloorName(floorName: floorName),
      ).called(1);

      verifyNoMoreInteractions(localDataSource);
    });

    test('should return a failure if getNumberOfParkingSlotsByFloorName fails', () async {
      // Arrange
      const floorName = "";
      when(() => localDataSource.getNumberOfSlotsByFloorName(floorName: floorName)).thenThrow(const LocalException.name(
        message: "Error",
        statusCode: 500,
      ));

      // Act
      final result = await repoImpl.getNumberOfParkingSlotsByFloorName(floorName: floorName);

      // Assert
      // Then
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getNumberOfSlotsByFloorName(floorName: floorName)).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
