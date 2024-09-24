import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final Widget? suffixicon;
  final void Function(String)? onchanged;
  const TextfieldWidget(
      {super.key,
      required this.controller,
      this.hint,
      this.label,
      this.onchanged,
      this.suffixicon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => onchanged,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 8),
          suffixIcon: suffixicon,
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(borderSide: BorderSide())),
    );
  }
}
