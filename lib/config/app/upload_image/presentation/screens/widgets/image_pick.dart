import 'package:e_chat/injection_container.dart';
import 'package:e_chat/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickImageUtils {
  factory PickImageUtils() {
    return _instance;
  }
  const PickImageUtils._();

  static const PickImageUtils _instance = PickImageUtils._();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image != null) {
        return XFile(image.path);
      }
      return null;
    } catch (e) {
      final permissionStatus = await Permission.photos.status;

      if (permissionStatus.isDenied) {
        await _showAlertPermissionsDialog();
      } else {
        debugPrint('Image Exception ==> $e');
      }
    }
    return null;
  }

  Future<void> _showAlertPermissionsDialog() {
    return showCupertinoDialog(
      context: getIt<GlobalKey<NavigatorState>>().currentState!.context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: CustomTextWidget(text: 'permissions_denied'.tr()),
          content: CustomTextWidget(text: 'allow_access_to_gallery_and_photos'.tr()),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: CustomTextWidget(text: 'cancel'.tr()),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: openAppSettings,
              child: CustomTextWidget(text: 'settings'.tr()),
            ),
          ],
        );
      },
    );
  }
}
