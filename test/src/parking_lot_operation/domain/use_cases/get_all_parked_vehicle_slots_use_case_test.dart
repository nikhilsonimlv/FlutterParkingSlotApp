import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/get_all_parked_vehicle_slots_use_case.dart';
import 'package:test/test.dart';

import 'parking_vehicle_repository.mock.dart';

void main() {
  late GetAllParkedVehicleSlotsUseCase getAllParkedVehicleSlotsUseCase;
  late ParkingVehicleRepository mockRepository;

  setUp(() {
    mockRepository = MockParkingVehicleRepository();
    getAllParkedVehicleSlotsUseCase = GetAllParkedVehicleSlotsUseCase(mockRepository);
  });

  test('Should call getAllParkedVehicleSlots on ParkingVehicleRepository', () async {
    // Arrange
    final List<ParkingVehicleEntity> expectedEntities = [
      const ParkingVehicleEntity(carSlotId: "1"),
      const ParkingVehicleEntity(carSlotId: "2"),
    ];

    when(() => mockRepository.getAllParkedVehicleSlots()).thenAnswer((_) async => Right(expectedEntities));

    // Act
    final result = await getAllParkedVehicleSlotsUseCase();

    // Assert
    expect(result, equals(Right(expectedEntities)));
    verify(() => mockRepository.getAllParkedVehicleSlots()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
