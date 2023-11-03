import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_available_parking_slot_by_car_size_use_case.dart';
import 'package:test/test.dart';

import 'parking_lot_repository.mock.dart';

void main() {
  late ParkingLotRepository mockRepository;
  late GetAvailableParkingSlotByCarSizeUseCase getAvailableParkingSlotByCarSizeUseCase;

  setUp(() {
    mockRepository = MockParkingLotRepository();
    getAvailableParkingSlotByCarSizeUseCase = GetAvailableParkingSlotByCarSizeUseCase(mockRepository);
  });

  test("should call [ParkingLotRepository.getNumberOfAvailableParkingSlotsByCarSize] method", () async {
    //Arrange

    const CarSize carSize = CarSize.xl;

    //Mock behaviour
    when(
      () => mockRepository.getNumberOfAvailableParkingSlotsByCarSize(carSize: carSize),
    ).thenAnswer((invocation) async => const Right(1));

    //Act
    final result = await getAvailableParkingSlotByCarSizeUseCase(carSize);

    //Assert
    expect(result, equals(const Right(1)));
    verify(() => mockRepository.getNumberOfAvailableParkingSlotsByCarSize(carSize: carSize)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
