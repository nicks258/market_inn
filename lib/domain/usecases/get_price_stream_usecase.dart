// domain/usecases/get_price_stream.dart
import 'package:dartz/dartz.dart';
import '../../core/data/error/failures.dart';

import '../entities/price.dart';
import '../repositories/websocket_repository.dart';

class GetPriceStreamUseCase {
  final PriceRepository repository;

  GetPriceStreamUseCase(this.repository);

  Stream<Either<Failure, Price>> call(String symbol) {
    return repository.getPriceStream(symbol);
  }
}
