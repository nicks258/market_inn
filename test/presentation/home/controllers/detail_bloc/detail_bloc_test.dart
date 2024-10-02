import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:market_inn/core/data/error/failures.dart';
import 'package:market_inn/core/utils/enums.dart';
import 'package:market_inn/domain/entities/company_detail.dart';
import 'package:market_inn/presentation/home/controllers/detail_bloc/detail_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/domain/usecases/mock_get_company_details_usecase.dart';

void main() {
  late DetailBloc detailBloc;
  late MockGetCompanyDetailsUseCase mockGetCompanyDetailsUseCase;

  setUp(() {
    mockGetCompanyDetailsUseCase = MockGetCompanyDetailsUseCase();
    detailBloc = DetailBloc(mockGetCompanyDetailsUseCase);
  });

  const tSymbol = 'AAPL';
  final tCompanyDetail = CompanyDetail(
    companyName: 'Apple Inc.',
    symbol: tSymbol,
    stockExchange: 'NASDAQ',
    companyIndustry: 'Technology',
    marketCapital: 2.5,
    stockCurrency: 'USD',
    companyLogo: 'https://apple.logo',
  );

  test('initial state is DetailState.internal', () {
    expect(detailBloc.state, equals(const DetailState.internal()));
  });

  test('should emit [loading, loaded] when data is successfully fetched',
      () async {
    when(() => mockGetCompanyDetailsUseCase(tSymbol))
        .thenAnswer((_) async => Right(tCompanyDetail));

    final expectedStates = [
      DetailState.internal(status: RequestStatus.loading),
      DetailState.internal(
          status: RequestStatus.loaded, companyDetail: tCompanyDetail),
    ];
    expectLater(detailBloc.stream, emitsInOrder(expectedStates));

    detailBloc.add(FetchDetailEvent(symbol: tSymbol));
  });

  test('should emit [loading, error] when fetching data fails', () async {
    when(() => mockGetCompanyDetailsUseCase(tSymbol)).thenAnswer(
        (_) async => Left(ServerFailure('Failed to fetch company details')));

    final expectedStates = [
      const DetailState.internal(),
      DetailState.internal(
          status: RequestStatus.error,
          message: 'Failed to fetch company details'),
    ];
    expectLater(detailBloc.stream, emitsInOrder(expectedStates));

    detailBloc.add(FetchDetailEvent(symbol: tSymbol));
  });
}
