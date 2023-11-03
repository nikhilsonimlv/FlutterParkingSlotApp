import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_parking_slots_by_car_size_use_case.dart';
import 'package:test/test.dart';

class MockParkingLotRepository extends Mock implements ParkingLotRepository {}

void main() {
  late GetParkingSlotsByCarSizeUseCase getParkingSlotsByCarSizeUseCase;
  late ParkingLotRepository mockRepository;

  setUp(() {
    mockRepository = MockParkingLotRepository();
    getParkingSlotsByCarSizeUseCase = GetParkingSlotsByCarSizeUseCase(mockRepository);
  });

  test('should call getNumberOfParkingSlotsByCarSize on repository', () async {
    // Arrange
    const CarSize carSize = CarSize.small;

    when(() => mockRepository.getNumberOfParkingSlotsByCarSize(carSize: carSize)).thenAnswer((_) async => const Right(20)); // Replace with your expected result

    // Act
    final result = await getParkingSlotsByCarSizeUseCase(carSize);

    // Assert
    expect(result, equals(const Right(20)));
    verify(() => mockRepository.getNumberOfParkingSlotsByCarSize(carSize: carSize)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
