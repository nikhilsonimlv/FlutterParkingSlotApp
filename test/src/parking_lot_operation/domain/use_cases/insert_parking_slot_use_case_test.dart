import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/repositories/parking_vehicle_repository.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/use_cases/insert_parking_slot_use_case.dart';
import 'package:test/test.dart';

class MockParkingVehicleRepository extends Mock implements ParkingVehicleRepository {}

void main() {
  late InsertParkingSlotUseCase insertParkingSlotUseCase;
  late ParkingVehicleRepository mockRepository;

  setUp(() {
    mockRepository = MockParkingVehicleRepository();
    insertParkingSlotUseCase = InsertParkingSlotUseCase(mockRepository);
  });

  test('should call insertParkingSlot on repository', () async {
    // Arrange
    final Vehicle vehicle = Vehicle(numberPlate: 'ABC123', carSize: CarSize.small);

    const parkingVehicleEntity = ParkingVehicleEntity(carNumber: 'ABC123', carSlotId: "1"); // Replace with your expected result
    when(() => mockRepository.insertParkingSlot(vehicle: vehicle)).thenAnswer((_) async => const Right(parkingVehicleEntity));

    // Act
    final result = await insertParkingSlotUseCase(vehicle);

    // Assert
    expect(result, equals(const Right(parkingVehicleEntity)));
    verify(() => mockRepository.insertParkingSlot(vehicle: vehicle)).called(1);
  });
}
