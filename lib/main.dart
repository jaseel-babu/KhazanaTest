import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/init_dependencies.dart';
import 'package:khazana_fintech_task/khazana.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await initDependencies();

  runApp(const Khazana());
}
