import 'package:khazana_fintech_task/features/auth/data/model/session_model.dart';
import 'package:khazana_fintech_task/features/auth/data/model/user_model.dart';
import 'package:khazana_fintech_task/features/auth/domain/entities/login_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginResponseModel extends LoginResponseEntity {
  LoginResponseModel({required super.sessionModel, required super.user});
  factory LoginResponseModel.fromJson(Map<String, dynamic> map) {
    return LoginResponseModel(
      sessionModel: map['session'],
      user: map['user']);
  }
   LoginResponseModel copyWith({
    Session? session,
  User? user,
  }) {
    return LoginResponseModel(
    sessionModel: session!,
    user: user!
    );
  }
}