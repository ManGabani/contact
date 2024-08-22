import 'package:flutter/cupertino.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';

class BuildTextButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const BuildTextButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: AppTextStyle.title.copyWith(
          color: ColorConst.primary,
        ),
      ),
    );
  }
}
