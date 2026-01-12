import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({this.hint, this.onChanged,this.obscureText, super.key,this.icon});
  String? hint;
  bool? obscureText;
  Icon? icon;
  Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextFormField(
        obscureText: obscureText ?? false,
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
          prefixIcon: icon,
        ),
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
