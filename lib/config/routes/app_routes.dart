import 'package:e_chat/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:e_chat/config/routes/based_rout.dart';
import 'package:e_chat/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:e_chat/features/chats/presentation/screens/chats_screen.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/features/message/presentation/screens/message_screen.dart';
import 'package:e_chat/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String chat = '/';
  static const String message = '/message';

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.chat,
    routes: [
      GoRoute(
        path: AppRoutes.chat,
        name: '/',
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => getIt<GetChatsCubit>()..fetchChats()),
            BlocProvider(create: (context) => getIt<UploadImageCubit>()),
          ],
          child: const ChatsScreen(),
        ),
      ),
      GoRoute(
          path: AppRoutes.message,
          name: 'message',
          pageBuilder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            final String friendId = args['friendId'];
            final String roomId = args['roomId'];
            final extra = state.extra as Map<String, dynamic>;

            return fadeScaleTransitionPage(
              key: state.pageKey,
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        getIt<MessageCubit>()..initChat(roomId, friendId),
                  ),
                  BlocProvider(create: (context) => getIt<ConnectivityCubit>())
                ],
                child: MessageScreen(
                  roomId: roomId,
                  friendId: friendId,
                  chatsEntity: extra['chatsEntity'] as ChatsEntity,
                ),
              ),
            );
          }),
    ],
  );
}
