import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hint, this.onChanged});
  String? hint;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'value is required';
          }
          return null;
        },
        onChanged: onChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
        ),
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
