import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:khazana_fintech_task/features/auth/data/model/session_model.dart';
import 'package:khazana_fintech_task/features/auth/data/model/user_model.dart';

class LoginResponseEntity {
  final Session sessionModel;
  final User user;
  LoginResponseEntity({
    required this.sessionModel,
    required this.user,
  });
}
