import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_chat/config/app/app_cubit/app_cubit.dart';
import 'package:e_chat/config/app/upload_image/data/data_source/upload_image_remote_data_source.dart';
import 'package:e_chat/config/app/upload_image/data/repositories/upload_image_repositories_impl.dart';
import 'package:e_chat/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:e_chat/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:e_chat/config/app/upload_image/presentation/manager/cubit/upload_image_cubit.dart';
import 'package:e_chat/core/helpers/hive_helper.dart';
import 'package:e_chat/core/network/connectivity_cubit/connectivity_cubit.dart';
import 'package:e_chat/core/services/contact_service.dart';
import 'package:e_chat/core/services/location_service.dart';
import 'package:e_chat/core/services/permission_service.dart';
import 'package:e_chat/features/chats/data/data_sources/chats_remote_data_source.dart';
import 'package:e_chat/features/chats/data/data_sources/chat_local_data_source.dart';
import 'package:e_chat/features/chats/data/repositories/chats_repository_impl.dart';
import 'package:e_chat/features/chats/domain/repositories/chats_repositories.dart';
import 'package:e_chat/features/chats/domain/use_cases/get_chat_use_case.dart';
import 'package:e_chat/features/chats/domain/use_cases/search_chats_use_case.dart';
import 'package:e_chat/features/chats/presentation/manager/get_chats_cubit/get_chats_cubit.dart';
import 'package:e_chat/features/message/data/data_sources/message_local_data_source.dart';
import 'package:e_chat/features/message/data/data_sources/message_remote_data_source.dart';
import 'package:e_chat/features/message/data/repositories/message_repo_impl.dart';
import 'package:e_chat/features/message/domain/repositories/message_repo.dart';
import 'package:e_chat/features/message/domain/use_cases/get_message_use_case.dart';
import 'package:e_chat/features/message/domain/use_cases/read_message_use_case.dart';
import 'package:e_chat/features/message/domain/use_cases/send_message_use_case.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/helpers/shared_prefrences.dart';
import 'core/network/netwok_info.dart';
import 'core/services/alert_service.dart';
import 'core/services/url_launcher_service.dart';

final getIt = GetIt.instance;

Future<void> getItInit() async {
  //! Features

  /// Blocs
  getIt.registerFactory<AppCubit>(() => AppCubit());
  getIt.registerFactory<ConnectivityCubit>(
      () => ConnectivityCubit(networkInfo: getIt()));
  getIt.registerFactory<UploadImageCubit>(
      () => UploadImageCubit(featureUc: getIt()));
  getIt.registerFactory<GetChatsCubit>(
      () => GetChatsCubit(getChatsUseCase: getIt(), searchChatsUseCase: getIt()));
  getIt.registerFactory<MessageCubit>(() => MessageCubit(
      getMessagesUseCase: getIt(),
      sendMessageUseCase: getIt(),
      readMessageUseCase: getIt(),
      uploadImageUseCase: getIt(),
      locationService: getIt(),
      contactService: getIt(),
      networkInfo: getIt()));

  /// Use cases
  getIt.registerLazySingleton<UploadImageUseCase>(
      () => UploadImageUseCase(uploadImageRepositories: getIt()));
  getIt.registerLazySingleton<GetChatsUseCase>(
      () => GetChatsUseCase(chatsRepositories: getIt()));
  getIt.registerLazySingleton<SearchChatsUseCase>(
      () => SearchChatsUseCase(chatsRepositories: getIt()));
  getIt.registerLazySingleton<ReadMessageUseCase>(
      () => ReadMessageUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<GetMessagesUseCase>(
      () => GetMessagesUseCase(messageRepository: getIt()));
  getIt.registerLazySingleton<SendMessageUseCase>(
      () => SendMessageUseCase(messageRepository: getIt()));

  /// Repository
  getIt.registerLazySingleton<UploadImageRepositories>(() =>
      UploadImageRepositoriesImpl(
          networkInfo: getIt(), uploadImageDataSource: getIt()));
  getIt.registerLazySingleton<ChatsRepositories>(() => ChatsRepositoryImpl(
      networkInfo: getIt(), chatsRemoteDataSource: getIt(), chatLocalDataSource: getIt()));
  getIt.registerLazySingleton<MessageRepository>(() =>
      MessageRepoImpl(networkInfo: getIt(), messageRemoteDataSource: getIt()));

  /// Data Sources
  getIt.registerLazySingleton<UploadImageRemoteDataSource>(
      () => UploadImageRemoteDataSourceImpl());
  getIt.registerLazySingleton<ChatsRemoteDataSource>(
      () => ChatsRemoteDataSourceImpl(mockChatDataSource: getIt()));
  getIt.registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl(hiveHelper: getIt()));
  getIt.registerLazySingleton<MessageRemoteDataSource>(
      () => MessageRemoteDataSourceImpl(messageLocalDataSource: getIt()));
  getIt.registerLazySingleton<MessageLocalDataSource>(() =>
      MessageLocalDataSourceImpl(
          hiveHelper: getIt(), chatsLocalDataSource: getIt()));

  /// Core
  getIt.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: getIt(), connectivity: getIt()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: getIt()));

  /// External
  SharedPreferences preferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => HiveHelper());
  getIt.registerLazySingleton(() => preferences);
  getIt.registerLazySingleton(() => AppInterceptors());
  // getIt.registerLazySingleton(() => LogInterceptor(
  //     request: true,
  //     requestBody: true,
  //     requestHeader: true,
  //     responseBody: true,
  //     responseHeader: false,
  //     error: true));
  getIt.registerLazySingleton(() => Connectivity());
  getIt.registerLazySingleton(() => InternetConnectionChecker());
  getIt.registerLazySingleton(() => CacheHelper());
  getIt.registerLazySingleton(() => UrlLauncherService());
  getIt.registerLazySingleton(() => PermissionService());
  getIt.registerLazySingleton(() => LocationService());
  getIt.registerLazySingleton(() => ContactService());
  getIt.registerLazySingleton(() => AlertService());
  getIt.registerLazySingleton(() => PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      ));
  getIt.registerLazySingleton(() => Dio());
}
