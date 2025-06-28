import '/ui/pages/splash.page.dart';

import '../ui/pages/pages.dart';

final appRoutes = {
  '/home': (_) => const HomePage(),
  '/login': (_) => const LoginPage(),
  '/favs': (_) => const PaginaFavoritos(),
  '/splash': (_) => const SplashPage(),
};
