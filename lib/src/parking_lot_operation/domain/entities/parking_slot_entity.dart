import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "ParkingSlotTable")
class ParkingSlotEntity extends Equatable {
  final int? id;
  @PrimaryKey()
  @ColumnInfo(name: "slot_id")
  final String slotID;
  final String slotSize;
  final int floor;

  final bool isOccupied;

  const ParkingSlotEntity({
    this.id,
    required this.slotID,
    required this.slotSize,
    required this.floor,
    required this.isOccupied,
  });

  @override
  List<Object?> get props => [
        slotID,
      ];
}
