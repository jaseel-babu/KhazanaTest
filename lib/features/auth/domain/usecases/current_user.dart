import 'package:fpdart/src/either.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/state_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<StateEntity, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, StateEntity>> call(NoParams params) async {
    return await authRepository.fetchState();
  }
}
