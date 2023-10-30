import 'package:flutter/material.dart';
import 'package:parkingslot/src/core/utils/constants.dart';
import 'package:parkingslot/src/parking_lot_operation/domain/entities/parking_vehicle_entity.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/info_row.dart';

class ParkingSlotCard extends StatelessWidget {
  final ParkingVehicleEntity? parkingVehicleEntity;
  final Function() onPressed;

  const ParkingSlotCard({
    super.key,
    this.parkingVehicleEntity,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.green], // Gradient colors
            begin: Alignment.topLeft, // Gradient start point
            end: Alignment.bottomRight, // Gradient end point
          ),
          borderRadius: BorderRadius.circular(10.0), // Border radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car Size: ${parkingVehicleEntity?.carSize}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              InfoRow(label: 'Car Number:', value: '${parkingVehicleEntity?.carNumber}'),
              const Divider(),
              InfoRow(label: 'Floor Number:', value: '${parkingVehicleEntity?.floorNumber}'),
              const Divider(),
              InfoRow(label: 'Bay ID:', value: '${parkingVehicleEntity?.floorNumber}:${parkingVehicleEntity?.bayNumber}'),
              const Divider(),
              InfoRow(label: 'Allocated Slot Type:', value: '${parkingVehicleEntity?.allocatedSlotType}'),
              const Divider(),
              InfoRow(label: 'Is Parked:', value: (parkingVehicleEntity?.isParked) ?? false ? 'Yes' : 'No'),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: onPressed,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            AppConstant.freeSlot,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
