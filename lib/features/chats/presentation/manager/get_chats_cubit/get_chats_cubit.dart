import 'dart:async';

import 'package:e_chat/features/chats/domain/entities/chats_entity.dart';
import 'package:e_chat/features/chats/domain/use_cases/get_chat_use_case.dart';
import 'package:e_chat/features/chats/domain/use_cases/search_chats_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsUseCase getChatsUseCase;
  List<ChatsEntity> allChats = [];
  final SearchChatsUseCase searchChatsUseCase;

  GetChatsCubit(
      {required this.getChatsUseCase, required this.searchChatsUseCase})
      : super(GetChatsInitial());

  Future<void> fetchChats() async {
    emit(GetChatsLoading());

    getChatsUseCase.call().listen((eitherResult) {
      eitherResult.fold(
        (failure) {
          emit(GetChatsError(errMsg: failure.massage));
        },
        (chatsList) {
          allChats = chatsList;
          emit(GetChatsSuccess(chatsList: chatsList));
        },
      );
    }, onError: (error) {
      emit(GetChatsError(errMsg: error.toString()));
    });
  }

  Future<void> searchChats(String query) async {
    emit(GetChatsLoading());

    final result = await searchChatsUseCase.call(query);

    result.fold(
      (failure) => emit(GetChatsError(errMsg: failure.massage)),
      (filteredChats) => emit(GetChatsSuccess(chatsList: filteredChats)),
    );
  }
}
