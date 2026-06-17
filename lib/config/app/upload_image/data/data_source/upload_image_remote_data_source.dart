import 'package:e_chat/config/app/upload_image/data/model/upload_image_response.dart';
import 'package:share_plus/share_plus.dart';

abstract class UploadImageRemoteDataSource {
  Future<UploadImageModel> postImage(XFile imageXFile);
}

class UploadImageRemoteDataSourceImpl implements UploadImageRemoteDataSource {
  @override
  Future<UploadImageModel> postImage(XFile imageXFile) async {

    await Future.delayed(const Duration(seconds: 2));

    return UploadImageModel(photo: imageXFile.path); 
  }
}