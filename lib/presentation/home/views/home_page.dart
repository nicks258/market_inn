// presentation/pages/Home_page.dart
import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/extensions/widget_extensions.dart';
import 'package:market_inn/core/presentation/widgets/spacer.dart';
import 'package:market_inn/presentation/home/components/instrument_tile.dart';

import '../../../core/domain/entities/instrument_model.dart';
import '../../../core/presentation/controllers/theme_bloc/theme_bloc.dart';
import '../../../core/presentation/widgets/colored_safe_area.dart';
import '../../../core/presentation/widgets/horizontal_line_widget.dart';

import '../../../core/services/service_locator.dart';
import '../controllers/home_bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  final List<InstrumentModelItem> instrumentList;

  const HomePage({super.key, required this.instrumentList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // final bloc = context.read<HomeBloc>();
    // for (final i in widget.instrumentList) {
    //   bloc.add(SubscribeToPricesEvent((i.symbol)));
    // }
    final bloc = sl<HomeBloc>();
    for (final i in widget.instrumentList) {
      bloc.add(SubscribeToPricesEvent((i.symbol)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return ColoredSafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (!state.isConnected) {
              return Center(child: Text('Reconnecting...'));
            } else if (state.errorMessage != null) {
              return Center(
                  child: Text(
                'Error: ${state.errorMessage}',
                style: TextStyle(color: Colors.black),
              ));
            } else {
              return Column(
                children: [
                  Container(
                    color: context.colors.primaryContainer,
                    width: context.width,
                    padding:
                        EdgeInsets.symmetric(vertical: context.height / 64),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Market inn',
                          style: context.textTheme.titleLarge!
                              .copyWith(color: Colors.white),
                        ).addPadding(
                            edgeInsets: EdgeInsets.symmetric(
                                horizontal: context.width / 64)),
                        AnimateIcon(
                          onTap: () {
                            if (Brightness.light ==
                                themeBloc.state.themeData.brightness) {
                              themeBloc.add(ToggleDarkThemeEvent());
                            } else {
                              themeBloc.add(ToggleLightThemeEvent());
                            }
                          },
                          iconType: IconType.animatedOnTap,
                          height: context.textTheme.titleLarge!.fontSize ?? 48,
                          color: Colors.white,
                          animateIcon: Brightness.light ==
                                  themeBloc.state.themeData.brightness
                              ? AnimateIcons.dayNightWeather
                              : AnimateIcons.fogWeather,
                        )
                      ],
                    ),
                  ),
                  heightSpacer(context.height / 32),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return HorizontalLineWidget(
                          height: 1,
                          width: context.width,
                        ).addPadding(
                            edgeInsets: EdgeInsets.symmetric(
                                vertical: context.height / 128));
                      },
                      itemCount: widget.instrumentList.length,
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width / 48),
                      itemBuilder: (context, index) {
                        final instrument = widget.instrumentList[index];
                        final priceEntity = state.prices[instrument.symbol];
                        final double price = priceEntity?.value ?? 0.0;
                        final double previousPrice =
                            priceEntity?.previousValue ?? 0.00;
                        final double differenceInPrice =
                            priceEntity?.priceDifference ?? 0;
                        // Determine price change
                        Color priceColor = Colors.transparent;
                        if (differenceInPrice > 0) {
                          priceColor = Colors.green; // Price Increased
                        } else if (differenceInPrice < 0) {
                          priceColor = Colors.red; // Price Decreased
                        } else if (price == previousPrice) {
                          priceColor = context.colors.onSurface;
                        }
                        return InstrumentTile(
                          differenceInPrice: differenceInPrice,
                          instrument: instrument,
                          price: price,
                          priceColor: priceColor,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
