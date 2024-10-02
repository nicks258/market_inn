import 'package:bloc_test/bloc_test.dart';
import 'package:market_inn/presentation/home/controllers/detail_bloc/detail_bloc.dart';

class MockDetailBloc extends MockBloc<DetailEvent, DetailState> implements DetailBloc {}