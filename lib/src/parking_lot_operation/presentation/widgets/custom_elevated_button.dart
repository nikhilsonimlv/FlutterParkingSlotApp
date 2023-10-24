import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final ButtonStyle? buttonStyle;
  final Widget? child;
  final double buttonHeight;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.buttonStyle,
    this.child,
    this.buttonHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: buttonHeight,
        child: TextButton(
          onPressed: onPressed,
          style: buttonStyle ??
              TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
          child: child ?? Text(buttonText),
        ),
      ),
    );
  }
}
