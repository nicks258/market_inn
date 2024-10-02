import 'package:bloc_test/bloc_test.dart';
import 'package:market_inn/presentation/home/controllers/home_bloc/home_bloc.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState>
    implements HomeBloc {}