import '/ui/pages/splash.page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'config/config.dart';
import 'ui/pages/pages.dart';

class SwapiApp extends StatelessWidget {
  const SwapiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Swapi App',
      theme: AppTheme.lightTheme,

      routes: appRoutes,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage();
          }
          return snapshot.hasData ? const HomePage() : const LoginPage();
        },
      ),
    );
  }
}
