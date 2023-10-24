import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_slot_entity.dart';

@Entity(tableName: "VehicleParkingTable", foreignKeys: [
  ForeignKey(
    childColumns: ['car_slot_id'],
    parentColumns: ['slot_id'],
    entity: ParkingSlotEntity,
  ),
])
class ParkingVehicleEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String? carSize;
  final String? carNumber;
  final int? floorNumber;
  @ColumnInfo(name: "car_slot_id")
  final String? carSlotId;
  final String? allocatedSlotType;
  final bool? isParked;

  const ParkingVehicleEntity({
    this.id,
    this.carSize = "",
    this.carNumber = "",
    this.floorNumber = 0,
    this.carSlotId,
    this.allocatedSlotType = "",
    this.isParked = false,
  });

  @override
  List<Object?> get props => [carSlotId];
}
