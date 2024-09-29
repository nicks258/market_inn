import 'package:flutter/material.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';


class HorizontalLineWidget extends StatelessWidget {
  const HorizontalLineWidget({super.key, this.width, this.height, this.color});
  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      width: width ?? context.width,
      color: color ?? context.colors.outline.withOpacity(0.2),
    );
  }
}
