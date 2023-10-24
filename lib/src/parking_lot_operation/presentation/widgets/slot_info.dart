import 'package:flutter/material.dart';
import 'package:parkingslot/src/core/params/params.dart';

class SlotInfoWidget extends StatelessWidget {
  final CarSize carSize;
  final int totalCount;
  final int availableCount;

  const SlotInfoWidget({super.key, required this.carSize, required this.totalCount, required this.availableCount});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(1.0), // Border radius
        ),
        child: Column(
          children: [
            Text(
              carSlotTypeValues.reverse[carSize]!,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Text(
              availableCount.toString(),
              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            Text((totalCount - availableCount).toString(), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
