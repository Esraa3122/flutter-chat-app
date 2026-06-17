import 'package:e_chat/core/usecases/usecase.dart';
import 'package:e_chat/features/first_feature/domain/entities/cat_fact_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/first_feature_uc.dart';

part 'cat_fact_state.dart';

class CatFactCubit extends Cubit<CatFactState> {
  final FirstFeatureUc featureUc;

  CatFactCubit({required this.featureUc}) : super(CatFactInitial());

  static CatFactCubit get(context) => BlocProvider.of(context);

  void getCatFact() async {
    emit(CatFactLoadingState());
    var response = await featureUc.call(NoParams());

    emit(response.fold((l) => CatFactErrorState(errMsg: l.massage),
        (r) => CatFactSuccessState(catFactEntity: r)));
  }
}
