import 'package:contact/constants/text_style.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;

  const TitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.title,
    );
  }
}
