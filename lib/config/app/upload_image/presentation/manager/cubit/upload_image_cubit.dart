import 'package:e_chat/config/app/upload_image/domain/entities/upload_image_entities.dart';
import 'package:e_chat/config/app/upload_image/domain/use_cases/upload_image_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  final UploadImageUseCase featureUc;

  UploadImageCubit({required this.featureUc}) : super(UploadImageStateInitial());

  static UploadImageCubit get(context) => BlocProvider.of(context);

  void postImage(XFile imageXFile) async {
    emit(UploadImageStateLoading());
    var response = await featureUc.call(imageXFile);

    emit(response.fold((l) => UploadImageStateError(error: l.massage),
        (r) => UploadImageStateSuccess(uploadImageEntities: r)));
  }
}
