import 'package:chooser/modules/welcome/presentation/pages/welcome_screen.dart';
import 'package:chooser/modules/home/presentation/pages/home_screen.dart';
import 'package:go_router/go_router.dart';


final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'none',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
