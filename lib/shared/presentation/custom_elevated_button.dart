import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.text, required this.onPressed, this.isLoading = false});

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: isLoading ? const CircularProgressIndicator.adaptive() : Text(text),
    );
  }

  void _onPressed() {
    if (isLoading) {
      return;
    }
    onPressed();
  }
}
