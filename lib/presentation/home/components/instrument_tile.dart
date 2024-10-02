import 'package:flutter/material.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/extensions/string_extensions.dart';

import '../../../core/domain/entities/instrument_model.dart';

class InstrumentTile extends StatelessWidget {
  const InstrumentTile({super.key, required this.instrument, required this.priceColor, required this.price, required this.differenceInPrice});

  final InstrumentModelItem instrument;
  final Color priceColor;
  final double price;
  final double differenceInPrice;

  @override
  Widget build(BuildContext context) {
     return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instrument.symbol,
              style: context.textTheme.labelLarge,
            ),
            Text(
              "${instrument.exchange} - ${instrument.type}",
              style: context.textTheme.bodySmall!
                  .copyWith(color: context.colors.outline),
            )
          ],
        ),
        AnimatedDefaultTextStyle(
          duration: Duration(milliseconds: 500),
          style: TextStyle(
            color: priceColor,
            // Set price text color based on price movement
            fontSize: 18.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price.toStringAsFixed(3).removeTrailingZeros(),
                // style: context.textTheme.bodyMedium,
              ),
              Text(
                differenceInPrice.toStringAsFixed(2),
                style: context.textTheme.bodySmall!
                    .copyWith(
                    color: context.colors.outline),
              )
            ],
          ),
        ),
      ],
    );
  }
}
