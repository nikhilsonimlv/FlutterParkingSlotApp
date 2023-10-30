import 'package:flutter/material.dart';

class FloorDropDown extends StatefulWidget {
  const FloorDropDown({super.key, required this.onChanged});

  final Function(String?) onChanged;

  @override
  State<FloorDropDown> createState() => _FloorDropDownState();
}

class _FloorDropDownState extends State<FloorDropDown> {
  String selectedLetter = 'A'; // Default selection

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLetter,
      onChanged: (String? newValue) {
        setState(() {
          selectedLetter = newValue!;
          widget.onChanged(selectedLetter);
        });
      },
      items: List.generate(26, (index) {
        final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
        return DropdownMenuItem<String>(
          value: letter,
          child: Text(letter),
        );
      }),
    );
  }
}
