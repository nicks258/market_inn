// presentation/pages/Home_page.dart
import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/extensions/widget_extensions.dart';
import 'package:market_inn/core/presentation/widgets/bottom_sheet_widget.dart';
import 'package:market_inn/core/presentation/widgets/spacer.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/core/utils/global_snakebar.dart';
import 'package:market_inn/presentation/home/components/instrument_tile.dart';
import 'package:market_inn/presentation/home/views/detail_page.dart';

import '../../../core/domain/entities/instrument_model.dart';
import '../../../core/presentation/controllers/theme_bloc/theme_bloc.dart';
import '../../../core/presentation/widgets/horizontal_line_widget.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/app_search_delegate.dart';
import '../controllers/detail_bloc/detail_bloc.dart';
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
    return BlocBuilder<HomeBloc, HomeState>(
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
                EdgeInsets.symmetric(vertical: context.height / 256),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Market Inn',
                      style: context.textTheme.titleLarge!
                          .copyWith(color: Colors.white),
                    ).addPadding(
                        edgeInsets: EdgeInsets.symmetric(
                            horizontal: context.width / 64)),
                    Row(
                      children: [
                        IconButton(
                          icon:  Icon(Icons.search, color: Colors.white,),
                          onPressed: () => showSearch(
                            context: context,
                            delegate: AppSearchDelegate(),
                          ),
                        ),
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
              heightSpacer(context.height / 32),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return HorizontalLineWidget().addPadding(
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
                    final double differenceInPrice =
                        priceEntity?.priceDifference ?? 0;
                    final isSymbolFound = priceEntity?.isSymbolFound?? true;
                    // Determine price change
                    Color priceColor = Colors.transparent;
                    if (differenceInPrice > 0) {
                      priceColor = Colors.green; // Price Increased
                    } else if (differenceInPrice < 0) {
                      priceColor = Colors.red; // Price Decreased
                    } else if (differenceInPrice==0) {
                      priceColor = context.colors.onSurface;
                    }
                    return InkWell(
                      onTap: () => InstrumentTypes.Stock.name==instrument.type? showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        builder: (context) {
                          return BlocProvider(
                            create: (context) => DetailBloc(sl())
                              ..add(FetchDetailEvent(
                                  symbol: instrument.symbol)),
                            child: BottomSheetWidget(child: DetailsPage()),
                          );
                        },
                      ):GlobalSnackBar.show(context,"Detail page is only available for stocks"),
                      child: Container(
                        color: !isSymbolFound? context.colors.outlineVariant: context.colors.surface,
                        child: InstrumentTile(
                          differenceInPrice: differenceInPrice,
                          instrument: instrument,
                          price: price,
                          priceColor: priceColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
