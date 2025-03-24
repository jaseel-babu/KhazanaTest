import 'dart:developer';

import 'package:fpdart/src/either.dart';
import 'package:khazana_fintech_task/core/error/exception.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/features/dashboard/data/datasources/mutual_fund_local_data_source.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/entities/mutual_fund_entity.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/repository/mutual_fund_repository.dart';

class MutualFundRepositoryImpl implements MutualFundRepository {
  final MutualFundLocalDataSource mutualFundLocalDataSource;

  MutualFundRepositoryImpl({required this.mutualFundLocalDataSource});
  @override
  Future<Either<Failure, List<MutualFundEntity>>> getAllFunds() async {
    try {
      final res = await mutualFundLocalDataSource.fetchMutualFunds();
      log("message");
      return right(res);
    } on ServerExceptions catch (e) { log("message");
      return left(Failure(e.message));
    }
  }
}
