import 'package:e_chat/core/app_constants/context_ext.dart';
import 'package:e_chat/core/utils/app_colors.dart';
import 'package:e_chat/features/message/presentation/manager/message_cubit/message_cubit.dart';
import 'package:e_chat/features/message/presentation/screens/widgets/icon_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AttachmentMenu extends StatelessWidget {
  final String roomId;
  final String ?friendId;
  const AttachmentMenu({super.key, required this.roomId, this.friendId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MessageCubit>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: context.color.popupMenu,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsLight.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(
                icon: Icons.camera_alt, 
                label: 'camera'.tr(), 
                onPressed: () => 
                cubit.sendImageMessage(roomId: roomId, friendId: friendId!, source: ImageSource.camera),),
              IconOptions(icon: Icons.person, label: 'contact'.tr(), onPressed: () { 
                cubit.sendContactMessage(chatId: roomId, friendId: friendId!);
               },),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconOptions(icon: Icons.photo, label: 'gallery'.tr(), onPressed:() => 
                cubit.sendImageMessage(roomId: roomId, friendId: friendId!, source: ImageSource.gallery),),
              IconOptions(icon: Icons.location_on, label: 'my_location'.tr(), onPressed: () {
                  cubit.sendLocationMessage(chatId: roomId, friendId: friendId!);
                },),
            ],
          ),
        ],
      ),
    );
  }
}