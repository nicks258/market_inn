import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/core/extensions/context_extensions.dart';
import 'package:market_inn/core/extensions/widget_extensions.dart';

import '../../../core/presentation/widgets/bottom_sheet_widget.dart';
import '../../../core/presentation/widgets/horizontal_line_widget.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/global_snakebar.dart';
import '../controllers/detail_bloc/detail_bloc.dart';
import '../controllers/search_bloc/search_bloc.dart';
import 'detail_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.searchResult != null &&
            state.searchResult!.isNotEmpty &&
            state.status == RequestStatus.loaded) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return HorizontalLineWidget().addPadding(
                  edgeInsets: EdgeInsets.symmetric(
                      vertical: context.height / 256));
            },
            shrinkWrap: true,
            itemCount: state.searchResult!.length,
            itemBuilder: (context, index) {
              final searchItem = state.searchResult![index];
              return ListTile(
                onTap: () => "Common Stock"==searchItem.type? showModalBottomSheet(
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
                            symbol: searchItem.displaySymbol)),
                      child: BottomSheetWidget(child: DetailsPage()),
                    );
                  },
                ):GlobalSnackBar.show(context,"Detail page is only available for stocks"),
                style: ListTileStyle.list,
                horizontalTitleGap: 0,
                visualDensity: VisualDensity.compact,
                title: Text(searchItem.description),
                subtitle: Text(searchItem.type, style: context.textTheme.bodySmall!.copyWith(color: context.colors.outline),),
              );
            },
          );
        } else if (state.searchResult != null &&
            state.status == RequestStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == RequestStatus.error) {
          return Center(
            child: Text('Error loading data'),
          );
        } else {
          return const Center(
            child: Text('No Results', style: TextStyle(fontSize: 24)),
          );
        }
      },
    );
  }
}
