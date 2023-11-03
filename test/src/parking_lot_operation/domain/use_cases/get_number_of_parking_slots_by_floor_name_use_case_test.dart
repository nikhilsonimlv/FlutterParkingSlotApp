import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_lot_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_number_of_parking_slots_by_floor_name_use_case.dart';
import 'package:test/test.dart';

import 'parking_lot_repository.mock.dart';

void main() {
  late GetNumberOfParkingSlotsByFloorNameUseCase getNumberOfParkingSlotsByFloorNameUseCase;
  late ParkingLotRepository mockRepository;

  setUp(() {
    mockRepository = MockParkingLotRepository();
    getNumberOfParkingSlotsByFloorNameUseCase = GetNumberOfParkingSlotsByFloorNameUseCase(mockRepository);
  });

  test('should call getNumberOfParkingSlotsByFloorName on repository', () async {
    // Arrange
    const String floorName = 'A';

    when(() => mockRepository.getNumberOfParkingSlotsByFloorName(floorName: floorName)).thenAnswer((_) async => const Right(10)); // Replace with your expected result

    // Act
    final result = await getNumberOfParkingSlotsByFloorNameUseCase(floorName);

    // Assert
    expect(result, equals(const Right(10)));
    verify(() => mockRepository.getNumberOfParkingSlotsByFloorName(floorName: floorName)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
