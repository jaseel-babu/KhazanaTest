import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
