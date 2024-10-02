import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/enums.dart';
import '../controllers/search_bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.searchResult != null &&
            state.searchResult!.isNotEmpty &&
            state.status == RequestStatus.loaded) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.searchResult!.length,
            itemBuilder: (context, index) {
              final searchItem = state.searchResult![index];
              return ListTile(
                title: Text(searchItem.description),
                subtitle: Text(searchItem.type),
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
