import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tihd/components/cached_image_widget.dart';
import 'package:tihd/components/loader_widget.dart';
import 'package:tihd/screens/profile/edit_profile/edit_profile_controller.dart';
import 'package:tihd/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tihd/generated/assets.dart';

class ProfilePicComponent extends StatelessWidget {
  ProfilePicComponent({super.key});

  final EditProfileController profileCont = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          CachedImageWidget(
            url: profileCont.imageFile.value.path.isNotEmpty
                ? profileCont.imageFile.value.path
                : profileCont.profilePic.value.isNotEmpty
                    ? profileCont.profilePic.value
                    : Assets.iconsIcUser,
            height: 120,
            width: 120,
            circle: true,
            fit: BoxFit.cover,
          ).paddingBottom(8),
          if (profileCont.isPicLoading.isTrue)
            Container(
              height: 120,
              width: 120,
              decoration: boxDecorationDefault(shape: BoxShape.circle, color: black.withValues(alpha: 0.6)),
              child: const LoaderWidget(),
            ),
          Positioned(
            bottom: 10,
            right: 2,
            child: InkWell(
              onTap: () {
                profileCont.showBottomSheet(context);
              },
              child: Container(
                height: 30,
                width: 30,
                padding: const EdgeInsets.all(4),
                decoration: boxDecorationDefault(
                  color: appColorPrimary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const CachedImageWidget(
                  url: Assets.iconsIcCamera,
                  height: 12,
                  width: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
