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
import 'package:khazana_fintech_task/features/dashboard/data/datasources/mutual_fund_local_data_source.dart';
import 'package:khazana_fintech_task/features/dashboard/data/repository/mutual_fund_repository_impl.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/repository/mutual_fund_repository.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/usecases/get_all_fund.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/bloc/mutualfund%20bloc/mutual_fund_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initMutuaFund();

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
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        logout: serviceLocator()));
}
void _initMutuaFund() {
  //DataSource
  serviceLocator
    ..registerFactory<MutualFundLocalDataSource>(
      () => MutualFundLocalDataSourceImpl(

      ),
    )

   
    //Repository
    ..registerFactory<MutualFundRepository>(
      () => MutualFundRepositoryImpl(
          mutualFundLocalDataSource: serviceLocator(),
        ),
    )
    //Usecase
    ..registerFactory(
      () => GetAllFundsUseCase(
        serviceLocator(),
      ),
    ) 
    //Bloc
    ..registerLazySingleton(() => MutualFundBloc(
       getAllFundsUseCase: serviceLocator()));
}
