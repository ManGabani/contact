import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    required this.labelText,
    this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.5),
        borderRadius: BorderRadiusDirectional.circular(15),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            errorText: errorText,
        ),
      ),
    );
  }
}
