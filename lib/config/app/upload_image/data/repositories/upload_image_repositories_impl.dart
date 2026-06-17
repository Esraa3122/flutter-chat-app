import 'package:dartz/dartz.dart';
import 'package:e_chat/config/app/upload_image/data/data_source/upload_image_remote_data_source.dart';
import 'package:e_chat/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:e_chat/config/app/upload_image/domain/repositories/upload_image_repositories.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:e_chat/core/network/netwok_info.dart';
import 'package:share_plus/share_plus.dart';

class UploadImageRepositoriesImpl implements UploadImageRepositories {
  final NetworkInfo networkInfo;
  final UploadImageRemoteDataSource uploadImageDataSource;

  UploadImageRepositoriesImpl(
      {required this.networkInfo, required this.uploadImageDataSource});

  @override
  Future<Either<Failure, UploadImageEntities>> postImage(XFile imageXFile) async {
    try {
      final response = await uploadImageDataSource.postImage(imageXFile);
      return Right(response);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
