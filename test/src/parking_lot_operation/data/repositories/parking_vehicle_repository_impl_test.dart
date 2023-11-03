import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/errors/exceptions.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/core/utils/util.dart';
import 'package:parkingslot/src/parking_lot_operation/data/data_sources/parking_lot_local_data_sources.dart';
import 'package:parkingslot/src/parking_lot_operation/data/repositories/parking_vehicle_repository_impl.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:test/test.dart';

import '../data_sources/parking_lot_local_data_sources_test.mock.dart';

class MockVehicle extends Mock implements Vehicle {}

void main() {
  late ParkingLotLocalDataSource localDataSource;
  late ParkingVehicleRepositoryImpl repoImpl;
  setUp(() {
    registerFallbackValue(MockVehicle());
    localDataSource = MockParkingLotLocalDataSource();
    repoImpl = ParkingVehicleRepositoryImpl(localDataSource);
  });

  group('freeParkingSlot', () {
    test('freeParkingSlot should return Right with an integer', () async {
      // Arrange
      const slotId = 'ABC123';

      when(() => localDataSource.deleteVehicleBySlotId(carSlotId: slotId)).thenAnswer((_) async => Future.value(1));
      when(() => localDataSource.updateAsFree(slotId: slotId)).thenAnswer((_) async => Future.value(1));

      // Act
      final result = await repoImpl.freeParkingSlot(slotId: slotId);

      // Assert
      expect(result, isA<Right>());
      verify(() => localDataSource.deleteVehicleBySlotId(carSlotId: slotId));
      verify(() => localDataSource.updateAsFree(slotId: slotId));
      expect(
          result.fold(
            (failure) {
              return failure;
            },
            (value) {
              return value;
            },
          ),
          1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('freeParkingSlot should return Left on exception', () async {
      // Arrange
      const slotId = '';
      when(() => localDataSource.deleteVehicleBySlotId(carSlotId: slotId)).thenThrow(const LocalException.name(
        message: "Error",
        statusCode: 500,
      ));
      when(() => localDataSource.updateAsFree(slotId: slotId)).thenThrow(const LocalException.name(
        message: "Error",
        statusCode: 500,
      ));

      // Act
      final result = await repoImpl.freeParkingSlot(slotId: slotId);

      // Assert
      expect(result, isA<Left>());
      verify(() => localDataSource.deleteVehicleBySlotId(carSlotId: slotId));
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());

      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("getAvailableParkingSlotByCarSize", () {
    test('getAvailableParkingSlotByCarSize should return Right with a ParkingSlotEntity', () async {
      // Arrange
      const carSize = CarSize.small;
      final mockParkingSlotEntity = ParkingSlotEntity(
        isOccupied: false,
        floorName: "A",
        slotSize: carSlotTypeValues.reverse[CarSize.small]!,
        slotID: "A:small:123",
        customBayId: 123,
      );
      when(() => localDataSource.getAvailableParkingSlotByCarSize(carSize: carSize)).thenAnswer((_) async => mockParkingSlotEntity);

      // Act
      final result = await repoImpl.getAvailableParkingSlotByCarSize(carSize: carSize);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(mockParkingSlotEntity));
    });

    test('getAvailableParkingSlotByCarSize should return Left on exception', () async {
      // Arrange
      const carSize = CarSize.small;
      when(() => localDataSource.getAvailableParkingSlotByCarSize(carSize: carSize)).thenThrow(
        const LocalException.name(message: "Error", statusCode: 500),
      );

      // Act
      final result = await repoImpl.getAvailableParkingSlotByCarSize(carSize: carSize);

      // Assert
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getAvailableParkingSlotByCarSize(carSize: carSize)).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("insertParkingSlot", () {
    setUp(() {
      registerFallbackValue(Vehicle(carSize: CarSize.small, numberPlate: "ABC123"));
    });
    test('should insert a parking slot successfully when there is an available slot', () async {
      // Given
      when(() => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: CarSize.small)).thenAnswer((_) async => 1);

      when(() => localDataSource.getAvailableParkingSlotByCarSize(carSize: CarSize.small)).thenAnswer((value) async => const ParkingSlotEntity(
            slotID: "A:small:abcd",
            slotSize: "Small",
            floorName: "A",
            customBayId: 1,
            isOccupied: false,
            id: 1,
          ));
      when(() => localDataSource.insertVehicleParkingSlot(
            vehicle: any(named: "vehicle"),
            bayNumber: 1,
            floor: "A",
            slotId: "A:small:abcd",
            allocatedSlotType: carSlotTypeValues.reverse[CarSize.small]!,
          )).thenAnswer((_) async => 1);

      when(() => localDataSource.updateAsOccupied(slotId: "A:small:abcd")).thenAnswer((_) async => 1);

      when(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: "A:small:abcd")).thenAnswer((_) async => const ParkingVehicleEntity(
            id: 1,
            carSize: 'Small',
            carNumber: 'ABC123',
            floorNumber: 'A',
            bayNumber: 1,
            carSlotId: 'A:small:abcd',
            allocatedSlotType: 'Small',
            isParked: true,
          ));

      // When
      final result = await repoImpl.insertParkingSlot(vehicle: Vehicle(carSize: CarSize.small, numberPlate: 'ABC123'));

      // Then
      expect(result.asRight(), isA<ParkingVehicleEntity>());
      verify(() => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: CarSize.small));
      verify(() => localDataSource.getAvailableParkingSlotByCarSize(carSize: CarSize.small));
      verify(() => localDataSource.insertVehicleParkingSlot(
            vehicle: any(named: "vehicle"),
            bayNumber: 1,
            floor: "A",
            slotId: "A:small:abcd",
            allocatedSlotType: carSlotTypeValues.reverse[CarSize.small]!,
          ));
      verify(() => localDataSource.updateAsOccupied(slotId: any(named: "slotId")));
      verify(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: any(named: "carSlotId")));
    });

    test('Insert parking slot with no available slots', () async {
      // Arrange
      when(() => localDataSource.getNumberOfAvailableParkingSlotByCarSize(carSize: CarSize.small)).thenThrow(
        const LocalException.name(message: "No SLOT FOUND", statusCode: 500),
      );

      // Act
      final result = await repoImpl.insertParkingSlot(vehicle: Vehicle(carSize: CarSize.small, numberPlate: 'ABC123'));
      // Assert
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      expect(
          result.fold((l) {
            return l.statusCode;
          }, (r) => null),
          500);
      expect(
          result.fold((l) {
            return l.errorMessage;
          }, (r) => null),
          "No SLOT FOUND");
    });
  });

  group("getParkedVehicleInfoBySLodId", () {
    test('getParkedVehicleInfoBySLodId should return Right with a ParkingVehicleEntity', () async {
      // Arrange
      const carSlotId = '123';
      const mockParkingVehicleEntity = ParkingVehicleEntity(
        id: 1,
        carSize: 'Medium',
        carNumber: 'ABC123',
        floorNumber: 'B',
        bayNumber: 101,
        carSlotId: '123',
        allocatedSlotType: 'Medium',
        isParked: true,
      );
      when(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: any(named: "carSlotId"))).thenAnswer((_) async => mockParkingVehicleEntity);

      // Act
      final result = await repoImpl.getParkedVehicleInfoBySLodId(carSlotId: carSlotId);

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(mockParkingVehicleEntity));
      verify(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: any(named: "carSlotId"))).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('getParkedVehicleInfoBySLodId should return Left on exception', () async {
      // Arrange
      const carSlotId = '';

      when(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: any(named: "carSlotId"))).thenThrow(
        const LocalException.name(message: "Error", statusCode: 500),
      );

      // Act
      final result = await repoImpl.getParkedVehicleInfoBySLodId(carSlotId: carSlotId);

      // Assert
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getParkedVehicleInfoBySlotId(carSlotId: any(named: "carSlotId"))).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group("getAllParkedVehicleSlots", () {
    test('getAllParkedVehicleSlots should return Right with a list of ParkingVehicleEntity', () async {
      // Arrange
      final mockParkingVehicleEntities = [
        const ParkingVehicleEntity(
          id: 1,
          carSize: 'Medium',
          carNumber: 'ABC123',
          floorNumber: 'B',
          bayNumber: 101,
          carSlotId: '123',
          allocatedSlotType: 'Medium',
          isParked: true,
        )
      ];
      when(() => localDataSource.getAllParkedVehicleSlots()).thenAnswer((_) async => mockParkingVehicleEntities);

      // Act
      final result = await repoImpl.getAllParkedVehicleSlots();

      // Assert
      expect(result, isA<Right>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => value,
          ),
          equals(mockParkingVehicleEntities));
      verify(() => localDataSource.getAllParkedVehicleSlots()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('getAllParkedVehicleSlots should return Left on exception', () async {
      // Arrange
      when(() => localDataSource.getAllParkedVehicleSlots()).thenThrow(
        const LocalException.name(message: "Error", statusCode: 500),
      );
      // Act
      final result = await repoImpl.getAllParkedVehicleSlots();
      // Assert
      expect(result, isA<Left>());
      expect(
          result.fold(
            (failure) => failure,
            (value) => null,
          ),
          isA<LocalFailure>());
      verify(() => localDataSource.getAllParkedVehicleSlots()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
