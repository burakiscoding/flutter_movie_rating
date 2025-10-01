import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.isLoading = false,
    required this.controller,
    this.hintText = '',
    this.validator,
  });

  final bool isLoading;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      enabled: !widget.isLoading,
      obscureText: _isPasswordHidden,

      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: _suffix(),
      ),
    );
  }

  Widget _suffix() {
    if (widget.isLoading) {
      return const CircularProgressIndicator.adaptive();
    }

    return GestureDetector(
      onTap: () => setState(() {
        _isPasswordHidden = !_isPasswordHidden;
      }),
      child: _isPasswordHidden ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
    );
  }
}
