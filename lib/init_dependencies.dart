import 'package:get_it/get_it.dart';
import 'package:khazana_fintech_task/core/secrets/app_secretes.dart';
import 'package:khazana_fintech_task/features/auth/data/datasources/auth_local_data_sources.dart';
import 'package:khazana_fintech_task/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:khazana_fintech_task/features/auth/data/repository/auth_repository_impl.dart';
import 'package:khazana_fintech_task/features/auth/domain/repository/auth_repository.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/current_user.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/logout.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/user_sign_in.dart';
import 'package:khazana_fintech_task/features/auth/domain/usecases/user_sign_up.dart';
import 'package:khazana_fintech_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();

  final supabase = await Supabase.initialize(
    url: AppSecreates.supabaseUrl,
    anonKey: AppSecreates.supabaseAnon,
  );

  //maintain single instance
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  //DataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )

    //DataSource

    ..registerFactory<AuthLocalDataSources>(
      () => AuthLocalDataSources(
        supabaseClient: serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
          authLocalDataSources: serviceLocator()),
    )
    //Usecase
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    ) //Usecase
    ..registerFactory(
      () => UserSignIn(
        serviceLocator(),
      ),
    )
    //usecase 
     ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    ) //usecase 
     ..registerFactory(
      () => Logout(
        serviceLocator(),
      ),
    )
    //Bloc
    ..registerLazySingleton(() => AuthBloc(
          userSignUp: serviceLocator(),
          userSignIn: serviceLocator(),currentUser: serviceLocator(),logout: serviceLocator()
        ));
}
