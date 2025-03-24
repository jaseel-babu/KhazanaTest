
import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/auth/domain/repository/auth_repository.dart';

class UserSignIn implements UseCase<UserEntity, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignIn( this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;
  UserSignInParams({
    required this.email,
    required this.password,
  });
}
