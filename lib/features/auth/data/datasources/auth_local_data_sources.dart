import 'dart:async';
import 'dart:convert';

import 'package:khazana_fintech_task/features/auth/domain/entities/state_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthLocalDataSources {
  final SupabaseClient supabaseClient;

  AuthLocalDataSources({required this.supabaseClient});
  Future<void> saveSession(Session session) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('supabase_session', jsonEncode(session.toJson()));
  }

  Future<StateEntity> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final sessionString = prefs.getString('supabase_session');

    if (sessionString == null) return StateEntity(); // No session found

    try {
      final sessionJson = jsonDecode(sessionString);
  
      final response = await supabaseClient.auth
          .recoverSession(sessionString);

      return StateEntity(
          id: sessionJson['user']['id'],
          userName: sessionJson['user']['user_metadata']['name']);
    } catch (e) {
      print("Session restoration failed: $e");
      return StateEntity();
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('supabase_session');

    await supabaseClient.auth.signOut();
  }
}
