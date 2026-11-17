
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'constants/app_colors.dart';
import 'config/supabase_config.dart';
import 'pages/home_page.dart';
import 'pages/auth_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
  );

  runApp(const EventTicketApp());
}

class EventTicketApp extends StatelessWidget {
  const EventTicketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATVENT - Discover Experiences',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: goldColor,
          brightness: Brightness.dark,
        ),
      ),
      home: const AuthGate(),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = supabase.auth.currentSession;

        if (session != null) {
          return const HomePage();
        }

        return const AuthPage();
      },
    );
  }
}
