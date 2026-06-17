
import 'package:e_chat/config/app/upload_image/domain/entities/upload_image_entities.dart';

class UploadImageModel extends UploadImageEntities {
  UploadImageModel({
    required super.photo,
  });

  factory UploadImageModel.fromJson(Map<String, dynamic> json) => UploadImageModel(
        // body: json['msg'] ?? '',
        photo: json['msg'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        // "body": body,
        "photo": photo,
      };
}
