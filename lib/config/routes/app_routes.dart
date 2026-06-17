import 'package:e_chat/features/first_feature/presentation/screens/feature_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home, 
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}