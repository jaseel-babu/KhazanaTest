import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/user_sign_in.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/entities/mutual_fund_entity.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/repository/mutual_fund_repository.dart';

class GetAllFundsUseCase implements UseCase< List<MutualFundEntity>, NoParams> {
  final MutualFundRepository mutualFundRepository;

  GetAllFundsUseCase(this.mutualFundRepository);
  @override
  Future<Either<Failure,  List<MutualFundEntity>>> call(NoParams noParams) async {
    return await mutualFundRepository.getAllFunds();
  }
}
