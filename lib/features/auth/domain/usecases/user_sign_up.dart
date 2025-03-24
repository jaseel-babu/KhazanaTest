
import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/core/usecase/usecase.dart';
import 'package:khazana_fintech_task/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<UserEntity, UserSignUpParms> {
  final AuthRepository authRepository;

  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, UserEntity>> call(UserSignUpParms params) async {
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParms {
  final String email; 
  final String name;
  final String password;
  UserSignUpParms({
    required this.email,
    required this.name,
    required this.password,
  });
}
