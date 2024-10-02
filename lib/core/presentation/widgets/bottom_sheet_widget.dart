import 'package:flutter/material.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';

import 'spacer.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget child;

  const BottomSheetWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            heightSpacer(context.height / 84),
            Container(
              height: 4,
              width: 32,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(64)),
                  color: context.colors.outlineVariant),
            ),
            heightSpacer(context.height / 64),
            child,
            heightSpacer(context.height / 16)
          ],
        ));
  }
}
