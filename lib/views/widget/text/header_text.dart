import 'package:contact/constants/text_style.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.header,
    );
  }
}
