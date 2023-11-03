import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/free_parking_slot_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_all_parked_vehicle_slots_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/insert_parking_slot_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/park_car_bloc/bloc/park_vehicle_bloc.dart';
import 'package:test/test.dart';

class MockInsertParkingSlotUseCase extends Mock implements InsertParkingSlotUseCase {}

class MockFreeParkingSlotUseCase extends Mock implements FreeParkingSlotUseCase {}

class MockGetAllParkedVehicleSlotsUseCase extends Mock implements GetAllParkedVehicleSlotsUseCase {}

void main() {
  late InsertParkingSlotUseCase mockInsertParkingSlotUseCase;
  late FreeParkingSlotUseCase mockFreeParkingSlotUseCase;
  late GetAllParkedVehicleSlotsUseCase mockGetAllParkedVehicleSlotsUseCase;

  //bloc
  late ParkVehicleBloc parkVehicleBloc;

  setUp(() {
    mockInsertParkingSlotUseCase = MockInsertParkingSlotUseCase();
    mockFreeParkingSlotUseCase = MockFreeParkingSlotUseCase();
    mockGetAllParkedVehicleSlotsUseCase = MockGetAllParkedVehicleSlotsUseCase();

    parkVehicleBloc = ParkVehicleBloc(
      insertParkingSlotUseCase: mockInsertParkingSlotUseCase,
      freeParkingSlotUseCase: mockFreeParkingSlotUseCase,
      getAllParkedVehicleSlotsUseCase: mockGetAllParkedVehicleSlotsUseCase,
    );
  });

  tearDown(() => parkVehicleBloc.close());

  test('Initial State should be ParkingLotState', () {
    expect(parkVehicleBloc.state, const ParkVehicleState());
  });

  group("carSizeHandler", () {
    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'emits car Size when CarSizeSelectEvent is added',
      build: () {
        return parkVehicleBloc;
      },
      act: (bloc) => bloc.add(const CarSizeSelectEvent(carSize: CarSize.small)),
      expect: () {
        return [
          const ParkVehicleState().copyWith(carSize: CarSize.small),
        ];
      },
    );
  });

  group("carSizeSubmitHandler", () {
    var mockVehicle = Vehicle(carSize: CarSize.small, numberPlate: "KA-12345");

    setUp(() {
      registerFallbackValue(mockVehicle);
    });

    var mockParkingVehicleEntity = ParkingVehicleEntity(
      id: 1,
      carSize: carSlotTypeValues.reverse[CarSize.small]!,
      carNumber: 'KA-12345',
      floorNumber: 'A',
      carSlotId: 'A-001',
      allocatedSlotType: 'Small',
      isParked: true,
    );
    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits parkingVehicleAdded state on success when SubmitCarSizeEvent added',
      build: () {
        when(() => mockInsertParkingSlotUseCase(any())).thenAnswer((_) async => Right(mockParkingVehicleEntity));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(const SubmitCarSizeEvent(carSize: CarSize.small));
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleAdding, updateSlotList: false),
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleAdded, parkingVehicleEntity: mockParkingVehicleEntity, updateSlotList: true),
        ];
      },
      verify: (bloc) {
        verify(() => mockInsertParkingSlotUseCase(any())).called(1);
      },
    );

    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits parkingVehicleError state on failure when SubmitCarSizeEvent added',
      build: () {
        when(() => mockInsertParkingSlotUseCase(any())).thenAnswer((_) async => const Left(LocalFailure(errorMessage: 'Failed', statusCode: 500)));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(const SubmitCarSizeEvent(carSize: CarSize.small));
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleAdding, updateSlotList: false),
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: 'Failed', updateSlotList: false),
        ];
      },
      verify: (bloc) {
        verify(() => mockInsertParkingSlotUseCase(any())).called(1);
      },
    );
  });

  group("freeSlotSubmitHandler", () {
    var mockParkingVehicleEntity = ParkingVehicleEntity(
      id: 1,
      carSize: carSlotTypeValues.reverse[CarSize.small]!,
      carNumber: 'KA-12345',
      floorNumber: 'A',
      carSlotId: 'A-001',
      allocatedSlotType: 'Small',
      isParked: true,
    );
    setUp(() {
      registerFallbackValue(mockParkingVehicleEntity);
    });

    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits parkingVehicleRemoved state on success when SubmitFreeSlotEvent added',
      build: () {
        when(() => mockFreeParkingSlotUseCase(any())).thenAnswer((_) async => const Right(1));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(SubmitFreeSlotEvent(parkingVehicleEntity: mockParkingVehicleEntity));
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleRemoving, updateSlotList: false),
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleRemoved, updateSlotList: true),
        ];
      },
      verify: (bloc) {
        verify(() => mockFreeParkingSlotUseCase(any())).called(1);
      },
    );

    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits parkingVehicleError state on failure when SubmitFreeSlotEvent added',
      build: () {
        when(() => mockFreeParkingSlotUseCase(any())).thenAnswer((_) async => const Left(LocalFailure(errorMessage: 'Failed', statusCode: 500)));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(SubmitFreeSlotEvent(parkingVehicleEntity: mockParkingVehicleEntity));
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleRemoving, updateSlotList: false),
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: "Failed"),
        ];
      },
      verify: (bloc) {
        verify(() => mockFreeParkingSlotUseCase(any())).called(1);
      },
    );
  });

  group("getAllParkedVehicleSlotsHandler", () {
    var mockParkingVehicleEntityList = [
      ParkingVehicleEntity(
        id: 1,
        carSize: carSlotTypeValues.reverse[CarSize.small]!,
        carNumber: 'KA-12345',
        floorNumber: 'A',
        carSlotId: 'A-001',
        allocatedSlotType: 'Small',
        isParked: true,
      )
    ];
    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits allParkedVehicleSlotsLoaded state on success when GetAllParkedVehicleSlotsEvent added',
      build: () {
        when(() => mockGetAllParkedVehicleSlotsUseCase()).thenAnswer((_) async => Right(mockParkingVehicleEntityList));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(const GetAllParkedVehicleSlotsEvent());
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.gettingAllParkedVehicleSlots, updateSlotList: false),
          const ParkVehicleState().copyWith(
              parkedVehicleList: mockParkingVehicleEntityList.reversed.toList(), parkingVehicleStatus: ParkingVehicleStatus.allParkedVehicleSlotsLoaded, updateSlotList: false),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetAllParkedVehicleSlotsUseCase()).called(1);
      },
    );

    blocTest<ParkVehicleBloc, ParkVehicleState>(
      'Emits parkingVehicleError state on failure when GetAllParkedVehicleSlotsEvent added',
      build: () {
        when(() => mockGetAllParkedVehicleSlotsUseCase()).thenAnswer((_) async => const Left(LocalFailure(errorMessage: 'Failed', statusCode: 500)));
        return parkVehicleBloc;
      },
      act: (parkVehicleBloc) {
        parkVehicleBloc.add(const GetAllParkedVehicleSlotsEvent());
      },
      expect: () {
        return [
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.gettingAllParkedVehicleSlots, updateSlotList: false),
          const ParkVehicleState().copyWith(parkingVehicleStatus: ParkingVehicleStatus.parkingVehicleError, errorMessage: "Failed"),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetAllParkedVehicleSlotsUseCase()).called(1);
      },
    );
  });
}
