import 'package:flutter/cupertino.dart';
import '../../../../constants/colors.dart';

class addbutton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const addbutton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CupertinoButton(
        padding: EdgeInsetsDirectional.zero,
        onPressed: onPressed,
        color: ColorConst.primary,
        borderRadius: BorderRadius.circular(13),
        child: Text(title),
      ),
    );
  }
}

