import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/utils/colors.dart';

import '../../main.dart';
import 'choose_option_screen.dart';
import 'walk_through_cotroller.dart';

class WalkThroughScreen extends StatelessWidget {
  final WalkThroughController walkThroughCont = Get.put(
    WalkThroughController(),
  );

  WalkThroughScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appScreenBackgroundDark,
      body: Obx(
        () => Stack(
          children: [
            // Main Background Color
            Container(color: appScreenBackgroundDark),

            // Background Image with Padding and Border
            _buildPaddedBackgroundImage(),

            // Content
            SafeArea(
              child: Column(
                children: [
                  // Skip Button
                  _buildSkipButton(),

                  // Page Content
                  Expanded(
                    child: PageView.builder(
                      itemCount: walkThroughCont.pages.length,
                      controller: walkThroughCont.pageController.value,
                      onPageChanged: (num) {
                        walkThroughCont.currentPosition.value = num + 1;
                      },
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final page = walkThroughCont.pages[index];
                        return _buildPageContent(page, index);
                      },
                    ),
                  ),

                  // Bottom Navigation
                  _buildBottomNavigation(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaddedBackgroundImage() {
    return Obx(() {
      final currentIndex = walkThroughCont.currentPosition.value - 1;
      if (currentIndex < 0 || currentIndex >= walkThroughCont.pages.length) {
        return SizedBox.shrink();
      }

      final page = walkThroughCont.pages[currentIndex];
      return AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        child: Container(
          key: ValueKey(page.image),
          margin: EdgeInsets.all(16), // Padding around image
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              22,
            ), // Slightly smaller than container
            child: Image.asset(
              page.image.validate(),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 450,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSkipButton() {
    return Align(
      alignment: Alignment.topRight,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity:
            walkThroughCont.currentPosition.value ==
                walkThroughCont.pages.length
            ? 0
            : 1,
        child: Container(
          margin: EdgeInsets.only(top: 12, right: 20),
          child: InkWell(
            onTap: () {
              Get.offAll(
                () => const ChooseOptionScreen(),
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                transition: Transition.fadeIn,
              );
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: Text(
                locale.value.lblSkip,
                style: primaryTextStyle(
                  color: white,
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(WalkThroughModelClass page, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Content Card
          AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            opacity: walkThroughCont.currentPosition.value == index + 1
                ? 1
                : 0.3,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Title with Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          page.title.toString(),
                          textAlign: TextAlign.center,
                          style: boldTextStyle(
                            size: 28,
                            color: white,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  20.height,

                  // Subtitle
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Text(
                      page.subTitle.toString(),
                      textAlign: TextAlign.center,
                      style: secondaryTextStyle(
                        size: 16,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
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

  Widget _buildBottomNavigation() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          // Custom Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              walkThroughCont.pages.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 6),
                width: walkThroughCont.currentPosition.value == index + 1
                    ? 24
                    : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: walkThroughCont.currentPosition.value == index + 1
                      ? appColorPrimary
                      : Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: walkThroughCont.currentPosition.value == index + 1
                      ? [
                          BoxShadow(
                            color: appColorPrimary.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          ),

          32.height,

          // Action Button
          InkWell(
            onTap: () async {
              if (walkThroughCont.currentPosition.value ==
                  walkThroughCont.pages.length) {
                Get.offAll(
                  () => const ChooseOptionScreen(),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  transition: Transition.fadeIn,
                );
              } else {
                walkThroughCont.pageController.value.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appColorPrimary, Color(0xFFFF69B4)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appColorPrimary.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    walkThroughCont.currentPosition.value ==
                            walkThroughCont.pages.length
                        ? locale.value.lblGetStarted
                        : locale.value.lblNext,
                    style: boldTextStyle(
                      size: 16,
                      color: white,
                      weight: FontWeight.w600,
                    ),
                  ),
                  if (walkThroughCont.currentPosition.value !=
                      walkThroughCont.pages.length) ...[
                    12.width,
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: white,
                        size: 16,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
