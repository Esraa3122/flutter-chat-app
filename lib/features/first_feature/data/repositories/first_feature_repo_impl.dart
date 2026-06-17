import 'package:dartz/dartz.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:e_chat/features/first_feature/data/data_sources/first_feature_remote_data_source.dart';
import 'package:e_chat/features/first_feature/domain/entities/cat_fact_entity.dart';
import 'package:e_chat/features/first_feature/domain/repositories/first_feature_repo.dart';

class FirstFeatureRepositoryImpl implements FirstFeatureRepository {
  final NetworkInfo networkInfo;
  final FirstFeatureRemoteDataSource firstFeatureRemoteDataSource;

  FirstFeatureRepositoryImpl(
      {required this.networkInfo, required this.firstFeatureRemoteDataSource});

  @override
  Future<Either<Failure, CatFactEntity>> getCatFact() async {
    try {
      final response = await firstFeatureRemoteDataSource.getCatFact();
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
