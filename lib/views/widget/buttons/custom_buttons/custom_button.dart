import 'package:flutter/cupertino.dart';

import '../../../../constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        onPressed: onPressed,
        color: ColorConst.primary,
        child: Text(title),
      ),
    );
  }
}

