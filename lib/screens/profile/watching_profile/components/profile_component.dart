import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/components/cached_image_widget.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/profile/watching_profile/components/verify_profile_pin_component.dart';
import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/colors.dart';
import '../model/profile_watching_model.dart';
import '../watching_profile_controller.dart';

class ProfileComponent extends StatefulWidget {
  final WatchingProfileModel profile;
  final WatchingProfileController profileWatchingController;
  final double height;
  final double width;
  final EdgeInsets padding;
  final double imageSize;

  const ProfileComponent({
    super.key,
    required this.profile,
    required this.profileWatchingController,
    required this.height,
    required this.width,
    required this.padding,
    required this.imageSize,
  });

  @override
  State<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends State<ProfileComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
    if (hovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCurrentProfile = widget.profile.id == profileId.value;
    final bool isChildProfile = widget.profile.isChildProfile == 1;
    
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: () {
            if (widget.profile.id != profileId.value) {
              if (widget.profile.isProtectedProfile.getBoolInt() &&
                  widget.profile.profilePin.isNotEmpty &&
                  (accountProfiles.any((element) => element.isChildProfile == 1) &&
                      selectedAccountProfile.value.isChildProfile.getBoolInt())) {
                Get.bottomSheet(
                  isDismissible: true,
                  isScrollControlled: true,
                  enableDrag: false,
                  VerifyProfilePinComponent(
                    profileWatchingController: widget.profileWatchingController,
                    profile: widget.profile,
                    onVerificationCompleted: () {
                      widget.profileWatchingController.handleSelectProfile(widget.profile);
                    },
                  ),
                );
              } else {
                widget.profileWatchingController.handleSelectProfile(widget.profile);
              }
            }
          },
          child: Container(
            height: widget.height,
            width: widget.width,
            padding: widget.padding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isCurrentProfile 
                    ? appColorPrimary.withOpacity(0.1)
                    : cardColor.withOpacity(0.9),
                  isCurrentProfile 
                    ? appColorPrimary.withOpacity(0.05)
                    : cardColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isCurrentProfile 
                  ? appColorPrimary.withOpacity(0.8)
                  : borderColor.withOpacity(0.3),
                width: isCurrentProfile ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(_isHovering ? 0.3 : 0.1),
                  blurRadius: _isHovering ? 15 : 8,
                  offset: Offset(0, _isHovering ? 6 : 3),
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Main Content - Using SingleChildScrollView to prevent overflow
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Profile Avatar Container
                          Container(
                            width: widget.imageSize,
                            height: widget.imageSize,
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isChildProfile 
                                  ? Colors.orange.withOpacity(0.8)
                                  : appColorPrimary.withOpacity(0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                if (_isHovering || isCurrentProfile)
                                  BoxShadow(
                                    color: (isCurrentProfile ? appColorPrimary : Colors.grey)
                                        .withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Profile Image
                                ClipOval(
                                  child: CachedImageWidget(
                                    url: widget.profile.avatar,
                                    width: widget.imageSize,
                                    height: widget.imageSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                
                                // Child Profile Indicator
                                if (isChildProfile)
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: widget.imageSize,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(widget.imageSize / 2),
                                          bottomRight: Radius.circular(widget.imageSize / 2),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        locale.value.kids,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          
                          SizedBox(height: constraints.maxHeight * 0.02),
                          
                          // Profile Name
                          SizedBox(
                            width: constraints.maxWidth * 0.9,
                            child: Text(
                              widget.profile.name.capitalizeEachWord(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          
                          SizedBox(height: constraints.maxHeight * 0.08),
                          
                          // Edit Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if ((widget.profile.isChildProfile.getBoolInt() ||
                                        widget.profile.isProtectedProfile.getBoolInt()) &&
                                    accountProfiles.any((element) =>
                                        element.isProtectedProfile.getBoolInt() &&
                                        element.profilePin.isNotEmpty)) {
                                  widget.profile.profilePin = selectedAccountProfile.value.profilePin;
                                  Get.bottomSheet(
                                    isDismissible: true,
                                    isScrollControlled: true,
                                    enableDrag: false,
                                    VerifyProfilePinComponent(
                                      profileWatchingController: widget.profileWatchingController,
                                      profile: widget.profile,
                                      onVerificationCompleted: () {
                                        widget.profileWatchingController.handleAddEditProfile(
                                            widget.profile, true);
                                      },
                                    ),
                                  );
                                } else {
                                  widget.profileWatchingController.handleAddEditProfile(
                                      widget.profile, true);
                                }
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.edit_outlined,
                                      size: 10,
                                      color: iconColor,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      locale.value.edit,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: iconColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Current Profile Indicator (Top Right)
                    if (isCurrentProfile)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: appColorPrimary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: appColorPrimary.withOpacity(0.5),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.check,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    
                    // Protected Profile Indicator (Top Left)
                    if (widget.profile.isProtectedProfile.getBoolInt() && 
                        widget.profile.profilePin.isNotEmpty)
                      Positioned(
                        top: -4,
                        left: -4,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: Icon(
                            Icons.lock_outline,
                            size: 9,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}