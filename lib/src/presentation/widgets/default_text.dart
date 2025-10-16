import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  const DefaultTextField({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onSaved: onSaved,
          decoration: InputDecoration(
            prefixIcon:
                icon == null ? null : Icon(icon, color: Colors.grey.shade700),
            hintText: hint,
            filled: true,
            fillColor: Colors.blueGrey.shade50,
            enabledBorder: border,
            border: border,
            focusedBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.blue),
            ),
            errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
