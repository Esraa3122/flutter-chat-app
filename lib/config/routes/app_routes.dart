import 'package:e_chat/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:e_chat/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:e_chat/features/chats/presentation/screens/chats_screen.dart';
import 'package:e_chat/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String home = '/home';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => getIt<GetChatsCubit>()..fetchChats()),
            BlocProvider(create: (context) => getIt<UploadImageCubit>()),
          ],
          child: const ChatsScreen(),
        ),
      ),
    ],
  );
}
