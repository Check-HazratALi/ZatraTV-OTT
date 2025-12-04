import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/components/app_scaffold.dart';

import '../../../components/cached_image_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  final ChangePasswordController changePassController = Get.put(
    ChangePasswordController(),
  );
  final GlobalKey<FormState> _changePassFormKey = GlobalKey();

  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scaffoldBackgroundColor: appScreenBackgroundDark,
      hasLeadingWidget: true,
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
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo/Image Section
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: CachedImageWidget(
                      url: Assets.imagesIcLogin,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),

                  40.height,

                  // Title Section
                  Text(
                    locale.value.changePassword,
                    textAlign: TextAlign.center,
                    style: boldTextStyle(size: 28, color: white),
                  ),
                  12.height,
                  Text(
                    locale.value.yourNewPasswordMust,
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(
                      size: 14,
                      color: Colors.grey[400],
                    ),
                  ),

                  40.height,

                  // Form Fields Section
                  Form(
                    key: _changePassFormKey,
                    child: Column(
                      children: [
                        // Old Password Field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: AppTextField(
                            textStyle: primaryTextStyle(color: white),
                            controller: changePassController.oldPasswordCont,
                            focus: changePassController.oldPasswordFocus,
                            nextFocus: changePassController.newPasswordFocus,
                            obscureText: true,
                            textFieldType: TextFieldType.PASSWORD,
                            cursorColor: appColorPrimary,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: locale.value.oldPassword,
                              hintStyle: secondaryTextStyle(
                                color: Colors.grey[500],
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[500],
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),

                        20.height,

                        // New Password Field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: AppTextField(
                            textStyle: primaryTextStyle(color: white),
                            controller: changePassController.newPasswordCont,
                            focus: changePassController.newPasswordFocus,
                            nextFocus:
                                changePassController.confirmPasswordFocus,
                            obscureText: true,
                            textFieldType: TextFieldType.PASSWORD,
                            cursorColor: appColorPrimary,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: locale.value.newPassword,
                              hintStyle: secondaryTextStyle(
                                color: Colors.grey[500],
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[500],
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),

                        20.height,

                        // Confirm Password Field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: AppTextField(
                            textStyle: primaryTextStyle(color: white),
                            controller:
                                changePassController.confirmPasswordCont,
                            focus: changePassController.confirmPasswordFocus,
                            obscureText: true,
                            textFieldType: TextFieldType.PASSWORD,
                            cursorColor: appColorPrimary,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: locale.value.confirmNewPassword,
                              hintStyle: secondaryTextStyle(
                                color: Colors.grey[500],
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[500],
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 18,
                              ),
                            ),
                          ),
                        ),

                        40.height,

                        // Submit Button
                        Obx(
                          () => SizedBox(
                            width: Get.width,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (await isNetworkAvailable()) {
                                  if (_changePassFormKey.currentState!
                                      .validate()) {
                                    _changePassFormKey.currentState!.save();
                                    changePassController.saveForm();
                                  }
                                } else {
                                  toast(locale.value.yourInternetIsNotWorking);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appColorPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                locale.value.submit,
                                style: boldTextStyle(size: 16, color: white),
                              ),
                            ),
                          ),
                        ),

                        20.height,

                        // Cancel Button
                        SizedBox(
                          width: Get.width,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey[700]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              locale.value.cancel,
                              style: boldTextStyle(
                                size: 16,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
