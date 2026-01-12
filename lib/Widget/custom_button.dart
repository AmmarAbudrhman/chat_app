import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({super.key, required this.text, required this.onPressed});
  final String text;
  VoidCallback? onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
