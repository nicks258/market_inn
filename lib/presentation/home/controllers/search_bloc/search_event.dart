part of 'search_bloc.dart';


class SearchEvent {

}

class GetSearchResultEvent extends SearchEvent {
  final String query;

  GetSearchResultEvent(this.query);
}
