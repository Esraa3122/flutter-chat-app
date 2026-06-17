part of 'cat_fact_cubit.dart';

@immutable
sealed class CatFactState {}

final class CatFactInitial extends CatFactState {}

final class CatFactLoadingState extends CatFactState {}

final class CatFactSuccessState extends CatFactState {
  final CatFactEntity catFactEntity;

  CatFactSuccessState({required this.catFactEntity});
}

final class CatFactErrorState extends CatFactState {
  final String errMsg;

  CatFactErrorState({required this.errMsg});
}
