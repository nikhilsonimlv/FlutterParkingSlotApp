import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/free_parking_slot_use_case.dart';

import 'parking_vehicle_repository.mock.dart';

void main() {
  late FreeParkingSlotUseCase freeParkingSlotUseCase;
  late ParkingVehicleRepository mockRepository;

  setUp(() {
    mockRepository = MockParkingVehicleRepository();
    freeParkingSlotUseCase = FreeParkingSlotUseCase(mockRepository);
  });

  test('should call [ParkingVehicleRepository.freeParkingSlot] method', () async {
    // Arrange
    const parkingVehicleEntity = ParkingVehicleEntity(carSlotId: "42");

    when(() => mockRepository.freeParkingSlot(slotId: parkingVehicleEntity.carSlotId!)).thenAnswer(
      (_) async => const Right(1),
    );
    // Act
    final result = await freeParkingSlotUseCase(parkingVehicleEntity);

    // Assert
    expect(result, equals(const Right(1)));
    verify(() => mockRepository.freeParkingSlot(slotId: parkingVehicleEntity.carSlotId!)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
