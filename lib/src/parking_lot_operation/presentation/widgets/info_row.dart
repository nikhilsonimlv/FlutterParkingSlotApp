import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(value ?? 'N/A', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }
}
