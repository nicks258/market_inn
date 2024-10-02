import 'package:flutter/material.dart';

import 'spacer.dart';

class ColumnChildren extends StatelessWidget {
  const ColumnChildren(
      {super.key,
      this.icon,
      this.labelStyle,
      this.textStyle,
      required this.text,
      this.label,
      this.crossAxisAlignment,
      this.mainAxisAlignment});
  final Widget? icon;
  final String? label;
  final String text;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      mainAxisAlignment: mainAxisAlignment??MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null) widthSpacer(8),
            if (label != null)
              Text(label ?? '',
                  style: labelStyle ??
                      Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black54)),
          ],
        ),
        Flexible(
          child: Text(text,
              textAlign: TextAlign.center,
              style: textStyle ??
                  Theme.of(context).textTheme.bodySmall),
        ),
      ],
    );
  }
}
