import 'package:fpdart/fpdart.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/state_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<Either<Failure, UserEntity>> signInWithEmailPassword(
      {required String email, required String password});
Future<Either<Failure, StateEntity>>  fetchState(
    );
    Future<Either<Failure, StateEntity>>  logout(
    );
}
