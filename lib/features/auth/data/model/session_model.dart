import 'package:khazana_fintech_task/features/auth/domain/entities/session_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SessionModel extends SessionEntity {
  SessionModel({required super.session});
   factory SessionModel.fromJson(Map<String, dynamic> map) {
    return SessionModel(
      session: map['session']);
  }
   SessionModel copyWith({
    Session? session,
  
  }) {
    return SessionModel(
    session: session!
    );
  }
}
