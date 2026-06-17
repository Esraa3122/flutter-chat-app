import 'package:dartz/dartz.dart';
import 'package:e_chat/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:e_chat/core/error/failures.dart';
import 'package:share_plus/share_plus.dart';

abstract class UploadImageRepositories {
  Future<Either<Failure, UploadImageEntities>> postImage(XFile imageXFile);
}
