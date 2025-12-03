import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/generated/assets.dart';
import '../../utils/app_common.dart';
import '../../utils/colors.dart';
import '../auth/sign_in/sign_in_screen.dart';
import '../dashboard/dashboard_screen.dart';

class ChooseOptionScreen extends StatelessWidget {
  const ChooseOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            Assets.imagesIcChooseOptionBg,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),

          // Dark Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                  appScreenBackgroundDark,
                ],
                stops: [0.0, 0.3, 0.6, 1.0],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Stack(
              children: [
                // Main Content
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(
                      24,
                      40,
                      24,
                      MediaQuery.of(context).padding.bottom + 40,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                          appScreenBackgroundDark,
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Welcome Text
                        Text(
                          "Welcome to",
                          style: secondaryTextStyle(
                            size: 16,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        8.height,
                        Text(
                          locale.value.optionTitle,
                          style: boldTextStyle(size: 32, color: white).copyWith(
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 15,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        16.height,
                        Text(
                          locale.value.optionDesp.toString(),
                          textAlign: TextAlign.center,
                          style: secondaryTextStyle(
                            size: 15,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.6,
                          ),
                        ),

                        40.height,

                        // Options Cards
                        _buildOptionCard(
                          icon: Icons.explore_rounded,
                          title: locale.value.explore,
                          subtitle: "Browse all content without login",
                          color: Color(0xFFFF69B4),
                          onTap: () {
                            Get.offAll(
                              () => DashboardScreen(
                                dashboardController: getDashboardController(),
                              ),
                              binding: BindingsBuilder(() {
                                getDashboardController().onBottomTabChange(0);
                              }),
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              transition: Transition.fadeIn,
                            );
                          },
                        ),

                        20.height,

                        _buildOptionCard(
                          icon: Icons.person_rounded,
                          title: locale.value.signIn,
                          subtitle: "Sign in for personalized experience",
                          color: appColorPrimary,
                          onTap: () {
                            Get.to(
                              () => SignInScreen(),
                              arguments: true,
                              duration: Duration(milliseconds: 600),
                              curve: Curves.easeInOut,
                              transition: Transition.rightToLeftWithFade,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: white, size: 30),
            ),

            16.width,

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: boldTextStyle(size: 20, color: white)),
                  4.height,
                  Text(
                    subtitle,
                    style: secondaryTextStyle(
                      size: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_rounded, color: white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
