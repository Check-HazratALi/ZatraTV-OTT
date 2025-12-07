import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/profile/components/delete_profile_component.dart';
import 'package:zatra_tv/screens/profile/watching_profile/watching_profile_controller.dart';
import 'package:zatra_tv/utils/colors.dart';

class AddUpdateProfileDialogComponent extends StatelessWidget {
  final bool isEdit;

  AddUpdateProfileDialogComponent({super.key, required this.isEdit});

  final WatchingProfileController profileWatchingController =
      Get.find<WatchingProfileController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            appScreenBackgroundDark,
            appScreenBackgroundDark.withOpacity(0.98),
            appScreenBackgroundDark.withOpacity(0.95),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            spreadRadius: 5,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: DraggableScrollableSheet(
          initialChildSize: 0.65,
          minChildSize: 0.4,
          maxChildSize: 0.85,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                key: profileWatchingController.editFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Drag Handle
                    Container(
                      width: 50,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    16.height,
                    
                    // Header
                    Text(
                      isEdit ? "Edit Profile" : "Add New Profile",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    8.height,
                    Text(
                      isEdit 
                        ? "Update your profile information" 
                        : "Create a new viewing profile",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                    24.height,
                    
                    // Avatar Selection
                    Container(
                      height: 110,
                      width: Get.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background Gradient
                          Container(
                            width: Get.width,
                            height: 90,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  appColorPrimary.withOpacity(0.15),
                                  Colors.transparent,
                                  appColorPrimary.withOpacity(0.15),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          
                          SizedBox(
                            height: 100,
                            child: PageView.builder(
                              controller: profileWatchingController.pageController,
                              onPageChanged: (page) {
                                profileWatchingController.currentIndex(page);
                                profileWatchingController.updateCenterImage(
                                  profileWatchingController.defaultProfileImage[page],
                                );
                              },
                              itemCount:
                                  profileWatchingController.defaultProfileImage.length,
                              itemBuilder: (context, index) {
                                return Obx(() {
                                  int middleIndex =
                                      profileWatchingController.currentIndex.value;
                                  bool isCenter = index == middleIndex;

                                  return GestureDetector(
                                    onTap: () {
                                      if (!isCenter) {
                                        profileWatchingController.pageController
                                            .animateToPage(
                                              index,
                                              duration: Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Avatar Container
                                          Container(
                                            height: isCenter ? 85 : 65,
                                            width: isCenter ? 85 : 65,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: isCenter
                                                    ? appColorPrimary
                                                    : Colors.transparent,
                                                width: isCenter ? 3 : 0,
                                              ),
                                              boxShadow: [
                                                if (isCenter)
                                                  BoxShadow(
                                                    color: appColorPrimary.withOpacity(0.4),
                                                    blurRadius: 15,
                                                    spreadRadius: 2,
                                                  ),
                                              ],
                                            ),
                                            child: ClipOval(
                                              child: Image.asset(
                                                profileWatchingController
                                                    .defaultProfileImage[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          
                                          // Selection Indicator
                                          if (isCenter)
                                            Positioned(
                                              bottom: -2,
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: appColorPrimary,
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  "Selected",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                          
                          // Navigation Indicators
                          Positioned(
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                if (profileWatchingController.currentIndex.value > 0) {
                                  profileWatchingController.pageController.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_rounded,
                                color: Colors.white.withOpacity(0.8),
                                size: 22,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: IconButton(
                              onPressed: () {
                                if (profileWatchingController.currentIndex.value < 
                                    profileWatchingController.defaultProfileImage.length - 1) {
                                  profileWatchingController.pageController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: Colors.white.withOpacity(0.8),
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    8.height,
                    Text(
                      "Select Avatar",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    24.height,
                    
                    // Profile Name Input
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.15),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        controller: profileWatchingController.saveNameController,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter profile name",
                          hintStyle: TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          prefixIcon: Container(
                            width: 50,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: Colors.white70,
                              size: 22,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return locale.value.nameCannotBeEmpty;
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          profileWatchingController.saveNameController.text = p0;
                          profileWatchingController.getBtnEnable();
                        },
                        onFieldSubmitted: (p0) {
                          profileWatchingController.saveNameController.text = p0;
                          profileWatchingController.getBtnEnable();
                          hideKeyboard(context);
                        },
                      ),
                    ),
                    24.height,
                    
                    // Children's Profile Toggle
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.child_care_rounded,
                                        color: Colors.orange,
                                        size: 20,
                                      ),
                                    ),
                                    12.width,
                                    Text(
                                      locale.value.childrenSProfile,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                8.height,
                                Padding(
                                  padding: const EdgeInsets.only(left: 38),
                                  child: Text(
                                    locale.value.madeForKidsUnder12,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white70,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          16.width,
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: profileWatchingController
                                          .isChildrenProfileEnabled.value
                                      ? appColorPrimary
                                      : Colors.white.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                              child: Switch(
                                value: profileWatchingController
                                    .isChildrenProfileEnabled
                                    .value,
                                onChanged: (value) {
                                  profileWatchingController
                                      .isChildrenProfileEnabled
                                      .value = value;
                                },
                                activeColor: appColorPrimary,
                                activeTrackColor: appColorPrimary.withOpacity(0.3),
                                inactiveThumbColor: Colors.white70,
                                inactiveTrackColor: Colors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.height,
                    
                    // Action Buttons
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          // Cancel/Delete Button
                          Expanded(
                            child: Material(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () async {
                                  if (isEdit) {
                                    profileWatchingController.saveNameController.clear();
                                    Get.bottomSheet(
                                      isDismissible: true,
                                      isScrollControlled: true,
                                      enableDrag: false,
                                      BackdropFilter(
                                        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                        child: DeleteProfileComponent(
                                          onDeleteAccount: () async {
                                            Get.back();
                                            await profileWatchingController
                                                .deleteUserProfile(
                                                  profileWatchingController
                                                      .selectedProfile
                                                      .value
                                                      .id
                                                      .toString(),
                                                  isFromProfileWatching: false,
                                                )
                                                .then((value) {
                                              Get.back();
                                            });
                                          },
                                          profileName: profileWatchingController
                                              .selectedProfile
                                              .value
                                              .name,
                                        ),
                                      ),
                                    ).then((value) {
                                      Get.back();
                                    });
                                  } else {
                                    Get.back();
                                  }
                                },
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isEdit ? "Delete Profile" : locale.value.cancel,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          16.width,
                          
                          // Save/Update Button
                          Expanded(
                            child: Obx(
                              () => Material(
                                borderRadius: BorderRadius.circular(14),
                                child: InkWell(
                                  onTap: profileWatchingController.isBtnEnable.value
                                      ? () async {
                                          if (profileWatchingController
                                              .saveNameController
                                              .text
                                              .isEmpty) {
                                            toast(locale.value.nameCannotBeEmpty);
                                            return;
                                          } else {
                                            Get.back();
                                            if (profileWatchingController
                                                .editFormKey.currentState!
                                                .validate()) {
                                              profileWatchingController.getBtnEnable();

                                              await profileWatchingController
                                                  .editUserProfile(
                                                isEdit,
                                                name: profileWatchingController
                                                    .saveNameController
                                                    .text,
                                              );
                                            }
                                          }
                                        }
                                      : null,
                                  borderRadius: BorderRadius.circular(14),
                                  child: Container(
                                    height: 56,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      gradient: profileWatchingController.isBtnEnable.value
                                          ? LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                appColorPrimary,
                                                appColorPrimary.withOpacity(0.8),
                                              ],
                                            )
                                          : null,
                                      color: profileWatchingController.isBtnEnable.value
                                          ? null
                                          : Colors.white.withOpacity(0.1),
                                      boxShadow: profileWatchingController.isBtnEnable.value
                                          ? [
                                              BoxShadow(
                                                color: appColorPrimary.withOpacity(0.3),
                                                blurRadius: 15,
                                                offset: const Offset(0, 5),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            isEdit
                                                ? Icons.update_rounded
                                                : Icons.save_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          8.width,
                                          Text(
                                            isEdit ? locale.value.update : locale.value.save,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.height,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}