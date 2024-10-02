import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';
import 'package:market_inn/presentation/home/views/search_page.dart';

import '../services/service_locator.dart';

class AppSearchDelegate extends SearchDelegate {
  // final List<SearchItem> searchResult;

  // AppSearchDelegate({required this.searchResult});

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchBloc>()..add(GetSearchResultEvent(query)),
      child: SearchPage(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => Container();

// @override
// Widget buildSuggestions(BuildContext context) {
//   final results = searchResult.where((SearchItem search) {
//     final String title = search.description.toLowerCase();
//     final String body = search.type.toLowerCase();
//     final String input = query.toLowerCase();
//
//     return title.contains(input) || body.contains(input);
//   }).toList();
//
//   return results.isEmpty
//       ? const Center(
//           child: Text('No Results', style: TextStyle(fontSize: 24)),
//         )
//       : SearchPage(searchResult: results);
// }
}
