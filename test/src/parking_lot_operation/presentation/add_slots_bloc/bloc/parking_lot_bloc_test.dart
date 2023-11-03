import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/errors/failure.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/add_parking_slot_info_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_available_parking_slot_by_car_size_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_number_of_parking_slots_by_floor_name_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_parking_slots_by_car_size_use_case.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/add_slots_bloc/bloc/parking_lot_bloc.dart';
import 'package:test/test.dart';

class MockAddParkingSlotInfoUseCase extends Mock implements AddParkingSlotInfoUseCase {}

class MockGetAvailableParkingSlotByCarSizeUseCase extends Mock implements GetAvailableParkingSlotByCarSizeUseCase {}

class MockGetParkingSlotsByCarSizeUseCase extends Mock implements GetParkingSlotsByCarSizeUseCase {}

class MockGetNumberOfParkingSlotsByFloorNameUseCase extends Mock implements GetNumberOfParkingSlotsByFloorNameUseCase {}

void main() {
  late AddParkingSlotInfoUseCase mockAddParkingSlotInfoUseCase;
  late GetAvailableParkingSlotByCarSizeUseCase mockGetAvailableParkingSlotByCarSizeUseCase;
  late GetParkingSlotsByCarSizeUseCase mockGetParkingSlotsByCarSizeUseCase;
  late GetNumberOfParkingSlotsByFloorNameUseCase mockGetNumberOfParkingSlotsByFloorNameUseCase;

  //Bloc
  late ParkingLotBloc parkingLotBloc;

  setUp(() {
    mockAddParkingSlotInfoUseCase = MockAddParkingSlotInfoUseCase();
    mockGetAvailableParkingSlotByCarSizeUseCase = MockGetAvailableParkingSlotByCarSizeUseCase();
    mockGetParkingSlotsByCarSizeUseCase = MockGetParkingSlotsByCarSizeUseCase();
    mockGetNumberOfParkingSlotsByFloorNameUseCase = MockGetNumberOfParkingSlotsByFloorNameUseCase();

    parkingLotBloc = ParkingLotBloc(
      getAvailableParkingSlotByCarSizeUseCase: mockGetAvailableParkingSlotByCarSizeUseCase,
      addParkingSlotInfoUseCase: mockAddParkingSlotInfoUseCase,
      getParkingSlotsByCarSizeUseCase: mockGetParkingSlotsByCarSizeUseCase,
      getNumberOfParkingSlotsByFloorNameUseCase: mockGetNumberOfParkingSlotsByFloorNameUseCase,
    );
  });

  tearDown(() => parkingLotBloc.close());

  test('Initial State should be ParkingLotState', () {
    expect(parkingLotBloc.state, const ParkingLotState());
  });

  group("getParkingSlotHandler", () {
    blocTest<ParkingLotBloc, ParkingLotState>(
      'emits ParkingSlotStatus.parkingSlotsLoaded when GetParkingSlotsByCarSizeEvent is added',
      build: () {
        // Arrange
        when(() => mockGetParkingSlotsByCarSizeUseCase(CarSize.small)).thenAnswer((_) async => const Right(2));
        when(() => mockGetParkingSlotsByCarSizeUseCase(CarSize.large)).thenAnswer((_) async => const Right(2));
        when(() => mockGetParkingSlotsByCarSizeUseCase(CarSize.medium)).thenAnswer((_) async => const Right(2));
        when(() => mockGetParkingSlotsByCarSizeUseCase(CarSize.xl)).thenAnswer((_) async => const Right(2));

        when(() => mockGetAvailableParkingSlotByCarSizeUseCase(CarSize.small)).thenAnswer((_) async => const Right(1));
        when(() => mockGetAvailableParkingSlotByCarSizeUseCase(CarSize.large)).thenAnswer((_) async => const Right(1));
        when(() => mockGetAvailableParkingSlotByCarSizeUseCase(CarSize.medium)).thenAnswer((_) async => const Right(1));
        when(() => mockGetAvailableParkingSlotByCarSizeUseCase(CarSize.xl)).thenAnswer((_) async => const Right(1));

        return parkingLotBloc;
      },
      act: (parkingLotBloc) => parkingLotBloc.add(const GetParkingSlotsByCarSizeEvent()),
      expect: () {
        return [
          const ParkingLotState().copyWith(parkingSlotStatus: ParkingSlotStatus.gettingParkingSlotsByCarSize),
          const ParkingLotState().copyWith(
            parkingSlotStatus: ParkingSlotStatus.parkingSlotsLoaded,
            totNoOfSmallSlots: 2,
            totNoOfMediumSlots: 2,
            totNoOfLargeSlots: 2,
            totNoOfExtraLargeSlots: 2,
            totNoOfOccupiedSmallSlots: 1,
            totNoOfOccupiedMediumSlots: 1,
            totNoOfOccupiedLargeSlots: 1,
            totNoOfOccupiedExtraLargeSlots: 1,
          ),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetParkingSlotsByCarSizeUseCase(CarSize.small)).called(1);
        verify(() => mockGetAvailableParkingSlotByCarSizeUseCase(CarSize.small)).called(1);
      },
    );
  });

  group("addParkingSlotsHandler", () {
    var parkingSlotParams = ParkingSlotParams.empty();
    setUp(() {
      registerFallbackValue(parkingSlotParams);
    });
    blocTest<ParkingLotBloc, ParkingLotState>(
      'emits ParkingSlotStatus.parkingSlotsAdded when AddParkingSlotsEvent is added',
      build: () {
        // Arrange
        when(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).thenAnswer((_) async => const Right(10));
        when(() => mockAddParkingSlotInfoUseCase(any())).thenAnswer((_) async => const Right([]));
        return parkingLotBloc;
      },
      act: (bloc) => bloc.add(const AddParkingSlotsEvent(
        floorNumber: 'A',
        numberOfSmallSlots: 2,
        numberOfLargeSlots: 3,
        numberOfMediumSlots: 1,
        numberOfExtraLargeSlots: 1,
      )),
      expect: () {
        return [
          const ParkingLotState().copyWith(parkingSlotStatus: ParkingSlotStatus.addingParkingSlots),
          const ParkingLotState().copyWith(parkingSlotStatus: ParkingSlotStatus.parkingSlotsAdded, floorNumber: 'A'),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).called(1);
        verify(() => mockAddParkingSlotInfoUseCase(any())).called(1);
      },
    );

    blocTest<ParkingLotBloc, ParkingLotState>(
      'Should emit parkingSlotError state on failure',
      build: () {
        // Arrange
        when(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).thenAnswer((_) async => const Right(10));
        when(() => mockAddParkingSlotInfoUseCase(any())).thenAnswer((_) async => const Left(LocalFailure(errorMessage: 'Failed', statusCode: 500))); // Mock failure response
        return parkingLotBloc;
      },
      act: (bloc) => bloc.add(const AddParkingSlotsEvent(
        floorNumber: 'A',
        numberOfSmallSlots: 2,
        numberOfLargeSlots: 3,
        numberOfMediumSlots: 1,
        numberOfExtraLargeSlots: 0,
      )),
      expect: () {
        return [
          const ParkingLotState().copyWith(parkingSlotStatus: ParkingSlotStatus.addingParkingSlots),
          const ParkingLotState().copyWith(
            parkingSlotStatus: ParkingSlotStatus.parkingSlotError,
            errorMessage: 'Failed',
          ),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).called(1);
        verify(() => mockAddParkingSlotInfoUseCase(any())).called(1);
      },
    );

    blocTest<ParkingLotBloc, ParkingLotState>(
      'Should emit parkingSlotError state on exception',
      build: () {
        // Arrange
        when(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).thenAnswer((_) async => const Right(10));
        when(() => mockAddParkingSlotInfoUseCase(any())).thenThrow('An exception occurred'); // Mock failure response
        return parkingLotBloc;
      },
      act: (bloc) => bloc.add(const AddParkingSlotsEvent(
        floorNumber: 'A',
        numberOfSmallSlots: 2,
        numberOfLargeSlots: 3,
        numberOfMediumSlots: 1,
        numberOfExtraLargeSlots: 0,
      )),
      expect: () {
        return [
          const ParkingLotState().copyWith(parkingSlotStatus: ParkingSlotStatus.addingParkingSlots),
          const ParkingLotState().copyWith(
            parkingSlotStatus: ParkingSlotStatus.parkingSlotError,
            errorMessage: 'An exception occurred',
          ),
        ];
      },
      verify: (bloc) {
        verify(() => mockGetNumberOfParkingSlotsByFloorNameUseCase('A')).called(1);
        verify(() => mockAddParkingSlotInfoUseCase(any())).called(1);
      },
    );
  });

  group("TabHandler", () {
    blocTest<ParkingLotBloc, ParkingLotState>(
      'emits page Index when TabChangeEvent is added',
      build: () {
        return parkingLotBloc;
      },
      act: (bloc) => bloc.add(const TabChangeEvent(tabIndex: 1)),
      expect: () {
        return [
          const ParkingLotState().copyWith(pageIndex: 1),
        ];
      },
    );
  });
}
