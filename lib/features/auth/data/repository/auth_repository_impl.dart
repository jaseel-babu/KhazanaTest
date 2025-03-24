import 'package:fpdart/src/either.dart';
import 'package:khazana_fintech_task/core/error/exception.dart';
import 'package:khazana_fintech_task/core/error/failures.dart';
import 'package:khazana_fintech_task/features/auth/data/datasources/auth_local_data_sources.dart';
import 'package:khazana_fintech_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:khazana_fintech_task/features/auth/data/model/user_model.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/state_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/user_entity.dart';
import 'package:khazana_fintech_task/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart ' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSources authLocalDataSources;
  AuthRepositoryImpl(
      {required this.authRemoteDataSource, required this.authLocalDataSources});
  @override
  Future<Either<Failure, UserEntity>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      await authLocalDataSources.saveSession(user.sessionModel);
      final res = UserModel.fromJson(user.user.toJson());
      return right(res);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      await authLocalDataSources.saveSession(user.sessionModel);
      final res = UserModel.fromJson(user.user.toJson());
      return right(res);
    } on sb.AuthException catch (e) {
      return left(Failure("Please check your credentials and try again."));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, StateEntity>> fetchState() async {
    try {
      final logged = await authLocalDataSources.restoreSession();

      return right(logged);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, StateEntity>> logout() async {
    try {
      final logged = await authLocalDataSources.logout();

      return right(StateEntity());
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerExceptions catch (e) {
      return left(Failure(e.message));
    }
  }
}
