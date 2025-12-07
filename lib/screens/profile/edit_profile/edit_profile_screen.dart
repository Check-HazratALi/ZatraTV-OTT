import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import 'components/form_fields_component.dart';
import 'components/profile_photo_component.dart';
import 'edit_profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final EditProfileController profileCont = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: profileCont.isLoading,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      appBartitleText: locale.value.editProfile,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.5,
                colors: [
                  appColorPrimary.withOpacity(0.1),
                  appScreenBackgroundDark,
                ],
              ),
            ),
          ),

          // Floating Particles
          ...List.generate(
            15,
            (index) => Positioned(
              top: Get.height * 0.1 + (index * 30),
              left: Get.width * (index % 3) * 0.33,
              child: Container(
                width: 2,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          AnimatedScrollView(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ProfilePicComponent(), EditFormFieldComponent()],
          ).paddingAll(16),
        ],
      ),
    );
  }
}
