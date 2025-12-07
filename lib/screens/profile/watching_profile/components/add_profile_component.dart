import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/profile/watching_profile/model/profile_watching_model.dart';
import 'package:zatra_tv/screens/profile/watching_profile/watching_profile_controller.dart';
import 'package:zatra_tv/screens/setting/pin_generation_bottom_sheet.dart';
import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/colors.dart';

class AddProfileComponent extends StatefulWidget {
  final WatchingProfileController profileWatchingController;
  final double height;
  final double width;
  final EdgeInsets padding;

  const AddProfileComponent({
    super.key,
    required this.profileWatchingController,
    required this.height,
    required this.width,
    required this.padding,
  });

  @override
  State<AddProfileComponent> createState() => _AddProfileComponentState();
}

class _AddProfileComponentState extends State<AddProfileComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _colorAnimation = ColorTween(
      begin: cardColor.withOpacity(0.9),
      end: appColorPrimary.withOpacity(0.15),
    ).animate(_animationController);
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

  void _handleTap() {
    if (profilePin.value.isEmpty && 
        selectedAccountProfile.value.isProtectedProfile.getBoolInt() && 
        !selectedAccountProfile.value.isChildProfile.getBoolInt()) {
      showConfirmDialogCustom(
        context,
        primaryColor: appColorPrimary,
        onAccept: (value) {
          Future.delayed(
            Duration(milliseconds: 200),
            () {
              Get.bottomSheet(
                PinGenerationBottomSheet(),
                isDismissible: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              ).then(
                (value) {
                  if (value == true) {
                    widget.profileWatchingController.isChildrenProfileEnabled.value = true;
                    widget.profileWatchingController.handleAddEditProfile(WatchingProfileModel(), false);
                  }
                },
              );
            },
          );
        },
        onCancel: (value) {
          widget.profileWatchingController.isChildrenProfileEnabled.value = false;
          widget.profileWatchingController.handleAddEditProfile(WatchingProfileModel(), false);
        },
        title: "Do you want to set PIN?",
        positiveText: locale.value.yes,
        negativeText: locale.value.no,
      );
    } else {
      widget.profileWatchingController.isChildrenProfileEnabled.value = false;
      widget.profileWatchingController.handleAddEditProfile(WatchingProfileModel(), false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: _handleTap,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Container(
                height: widget.height,
                width: widget.width,
                padding: widget.padding,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _colorAnimation.value!,
                      _colorAnimation.value!.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovering 
                      ? appColorPrimary.withOpacity(0.6)
                      : borderColor.withOpacity(0.4),
                    width: _isHovering ? 2 : 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovering ? 0.25 : 0.1),
                      blurRadius: _isHovering ? 20 : 10,
                      offset: Offset(0, _isHovering ? 8 : 4),
                      spreadRadius: _isHovering ? 1 : 0,
                    ),
                    if (_isHovering)
                      BoxShadow(
                        color: appColorPrimary.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Main Content
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Animated Plus Icon Container
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: widget.width * 0.4,
                          height: widget.width * 0.4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: _isHovering
                                ? [appColorPrimary, appColorPrimary.withOpacity(0.8)]
                                : [btnColor, btnColor.withOpacity(0.8)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: (_isHovering ? appColorPrimary : btnColor)
                                    .withOpacity(_isHovering ? 0.5 : 0.3),
                                blurRadius: 15,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                          child: RotationTransition(
                            turns: _rotateAnimation,
                            child: Icon(
                              Icons.add,
                              color: iconColor,
                              size: 32,
                            ),
                          ),
                        ),
                        
                        14.height,
                        
                        // Add Profile Text with Animation
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: _isHovering ? 0.9 : 1.0,
                          child: Container(
                            constraints: BoxConstraints(maxWidth: widget.width - 20),
                            child: Text(
                              locale.value.addProfile,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _isHovering ? appColorPrimary : white,
                                letterSpacing: 0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        
                        8.height,
                        
                        // Subtitle Text
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                          opacity: _isHovering ? 1.0 : 0.6,
                          child: Text(
                            "Create new profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    // Hover Overlay Effect
                    if (_isHovering)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: RadialGradient(
                              center: Alignment.center,
                              radius: 0.8,
                              colors: [
                                appColorPrimary.withOpacity(0.1),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    
                    // Corner Accent (Top Right)
                    if (_isHovering)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: appColorPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    
                    // Corner Accent (Bottom Left)
                    if (_isHovering)
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: appColorPrimary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}