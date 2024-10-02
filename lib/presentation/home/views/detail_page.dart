import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/extensions/widget_extensions.dart';
import 'package:market_inn/core/presentation/widgets/column_children.dart';
import 'package:market_inn/core/presentation/widgets/horizontal_line_widget.dart';
import 'package:market_inn/core/presentation/widgets/network_image_widget.dart';
import 'package:market_inn/core/presentation/widgets/spacer.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/presentation/home/controllers/detail_bloc/detail_bloc.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        final companyDetails = state.companyDetail;
        switch (state.status) {
          case RequestStatus.loading:
            return Center(child: CircularProgressIndicator());

          case RequestStatus.loaded:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      companyDetails!.companyName,
                      style: context.textTheme.titleLarge!
                          .copyWith(color: context.colors.primaryContainer),
                    ),
                    Text(" (${companyDetails.symbol})")
                  ],
                ),
                Text(
                  companyDetails.stockExchange,
                  style: context.textTheme.bodySmall!
                      .copyWith(color: context.colors.outline),
                ),
                HorizontalLineWidget().addPadding(
                    edgeInsets:
                        EdgeInsets.symmetric(vertical: context.height / 128)),
                heightSpacer(context.height/128),
                IntrinsicHeight(
                  child: Row(
                    children: [
                      NetworkImageWidget(
                        imageUrl: companyDetails.companyLogo,
                        width: context.width / 12,
                        height: context.width/12,
                      ),
                      widthSpacer(context.width/128),

                      ColumnChildren(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        text: companyDetails.companyIndustry,
                        label: "Sector",
                      ),
                      widthSpacer(context.width/256),
                      VerticalDivider(
                        thickness: 0.5,
                      ),
                      widthSpacer(context.width/256),
                      ColumnChildren(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        text:
                            "${companyDetails.marketCapital.toStringAsFixed(2)} ${companyDetails.stockCurrency}",
                        label: "Market Cap",
                      ),
                    ],
                  ),
                )
              ],
            ).addPadding(edgeInsets: EdgeInsets.symmetric(horizontal: context.width/64));
          case RequestStatus.error:
            return Center(
              child: Text(state.message ?? ""),
            );
          default:
            return SizedBox.shrink();
        }
      },
    );
  }
}
