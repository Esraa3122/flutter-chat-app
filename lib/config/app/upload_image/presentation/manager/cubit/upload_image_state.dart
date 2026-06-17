part of 'upload_image_cubit.dart';

@immutable
sealed class UploadImageState {}

final class UploadImageStateInitial extends UploadImageState {}

final class UploadImageStateLoading extends UploadImageState {}

final class UploadImageStateLoadingList extends UploadImageState {
  final int index;
  UploadImageStateLoadingList({required this.index});
}

final class UploadImageStateSuccess extends UploadImageState {
  final UploadImageEntities uploadImageEntities;
  UploadImageStateSuccess({required this.uploadImageEntities});
}

final class UploadImageStateRemoveImage extends UploadImageState {
  final String imageUrl;
  UploadImageStateRemoveImage({required this.imageUrl});
}

final class UploadImageStateError extends UploadImageState {
  final String error;
  UploadImageStateError({required this.error});
}
