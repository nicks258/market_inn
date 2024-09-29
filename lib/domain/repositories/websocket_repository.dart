// domain/repositories/websocket_repository.dart
import 'package:dartz/dartz.dart';
import '../../core/data/error/failures.dart';

import '../entities/price.dart';

abstract class PriceRepository {
  Stream<Either<Failure, Price>> getPriceStream(String symbol);
  Future<Price?> getLatestPriceFromApi(String symbol);

  void dispose();
}
