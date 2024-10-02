import 'package:flutter/material.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';

class GlobalSnackBar {
  final String message;

  const GlobalSnackBar({
    required this.message,
  });

  static show(
      BuildContext context,
      String message,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Text(message,style: context.textTheme.bodyMedium!
            .copyWith(color: context.colors.surface),),
        duration: const Duration(seconds: 5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
      ),
    );
  }
}