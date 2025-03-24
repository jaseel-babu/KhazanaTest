import 'package:supabase_flutter/supabase_flutter.dart';

class LoginResponseEntity {
  final Session sessionModel;
  final User user;
  LoginResponseEntity({
    required this.sessionModel,
    required this.user,
  });
}
