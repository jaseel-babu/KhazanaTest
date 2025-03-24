import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/features/dashboard/data/model/mutual_fund_model.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/entities/mutual_fund_entity.dart';

abstract interface class MutualFundRepository {
  Future<Either<Failure, List<MutualFundEntity>>> getAllFunds();
}
