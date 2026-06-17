import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/usecases/usecase.dart';
import 'package:e_chat/features/first_feature/domain/entities/cat_fact_entity.dart';
import 'package:e_chat/features/first_feature/domain/repositories/first_feature_repo.dart';

class FirstFeatureUc implements UseCase<CatFactEntity, NoParams> {
  final FirstFeatureRepository firstFeatureRepository;

  FirstFeatureUc({required this.firstFeatureRepository});

  @override
  Future<Either<Failure, CatFactEntity>> call(NoParams params) {
    return firstFeatureRepository.getCatFact();
  }
}
