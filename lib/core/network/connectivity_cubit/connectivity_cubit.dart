
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:flutter/foundation.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
 final NetworkInfo networkInfo; 
  late StreamSubscription _subscription;

  ConnectivityCubit({required this.networkInfo}) : super(ConnectivityInitial()) {
    _checkInitialConnection();
    
    _subscription = networkInfo.onConnectivityChanged.listen((hasInternet) {
      if (hasInternet) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    });
  }

  Future<void> _checkInitialConnection() async {
    bool hasInternet = await networkInfo.isConnected;
    
    if (hasInternet) {
      emit(ConnectivityConnected());
    } else {
      emit(ConnectivityDisconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}