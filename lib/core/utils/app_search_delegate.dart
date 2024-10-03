import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';
import 'package:market_inn/presentation/home/views/search_page.dart';

class AppSearchDelegate extends SearchDelegate {
  String? _previousQuery;
  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query.isEmpty ? close(context, null) : query = '',
    ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
   return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Get the existing Bloc instance instead of re-creating it
    final searchBloc = BlocProvider.of<SearchBloc>(context);


    if (query.isNotEmpty && query != _previousQuery) {
      _previousQuery = query;
      // Add event to the existing Bloc instance
      debugPrint("adding event $query");
      searchBloc.add(GetSearchResultEvent(query));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SearchPage();
      });
  }
}
