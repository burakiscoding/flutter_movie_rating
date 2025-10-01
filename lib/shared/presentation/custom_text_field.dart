import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.isLoading = false,
    required this.controller,
    this.hintText = '',
    this.validator,
    this.maxLength,
    this.maxLines,
  });

  final bool isLoading;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: _suffix(),
      ),
      enabled: !isLoading,
    );
  }

  Widget? _suffix() {
    if (isLoading) {
      return const CircularProgressIndicator.adaptive();
    }

    return null;
  }
}
