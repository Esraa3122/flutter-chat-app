import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/cat_fact_entity.dart';

abstract class FirstFeatureRepository {
  Future<Either<Failure, CatFactEntity>> getCatFact();
}
