import 'package:bloc_test/bloc_test.dart';
import 'package:market_inn/presentation/home/controllers/search_bloc/search_bloc.dart';

class MockSearchBloc extends MockBloc<SearchEvent,SearchState> implements SearchBloc {}