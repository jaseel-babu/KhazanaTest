import 'package:khazana_fintech_task/core/error/exception.dart';
import 'package:khazana_fintech_task/features/auth/data/model/login_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<LoginResponseModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<LoginResponseModel> signInWithEmailPassword(
      {required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<LoginResponseModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerExceptions('User is Null');
      }
      return LoginResponseModel(
          sessionModel: response.session!, user: response.user!);
    } on AuthApiException catch (e) {
      throw ServerExceptions(e.message.toString());
    } catch (e) {
      throw ServerExceptions(e.toString());
    }
  }

  @override
  Future<LoginResponseModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      print(response.user?.id);
      if (response.user == null) {
        throw ServerExceptions('User is Null');
      }

      return LoginResponseModel(
          sessionModel: response.session!, user: response.user!);
    } on AuthApiException catch (e) {
      throw ServerExceptions(e.message.toString());
    } catch (e) {
      print(e.runtimeType);
      throw ServerExceptions(e.toString());
    }
  }
}
