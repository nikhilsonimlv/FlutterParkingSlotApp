import 'package:flutter/material.dart';
import 'package:parkingslot/src/core/params/params.dart';
import 'package:parkingslot/src/parking_lot_operation/presentation/widgets/custom_text_field.dart';

class SlotWidget extends StatelessWidget {
  final CarSize carSize;
  final TextEditingController textEditingController;
  final Function(String)? onChanged;

  const SlotWidget({super.key, required this.carSize, required this.textEditingController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(child: Align(alignment: Alignment.center, child: Text("No. of ${carSlotTypeValues.reverse[carSize]!} slots"))),
          Expanded(
            child: CustomTextField(
              label: carSlotTypeValues.reverse[carSize]!,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
