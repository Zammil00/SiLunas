import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // INIT SUPABASE NYA
  Supabase supabase = await Supabase.initialize(
    url: "https://vzidonrguobywxcyqczd.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ6aWRvbnJndW9ieXd4Y3lxY3pkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcyNDMwNzksImV4cCI6MjA3MjgxOTA3OX0.3U1JuRZHMelF5ZJHKBgoZmYCNy-y4CoTuhUqZq_gd8U",
  );

  if (kDebugMode) {
    print("SUPABASE INFORMATION ? = ${supabase.client.auth.currentSession}");
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
