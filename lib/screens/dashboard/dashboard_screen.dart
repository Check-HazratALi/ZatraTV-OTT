import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/colors.dart';
import 'components/menu.dart';
import 'dashboard_controller.dart';
import 'floting_action_bar/floating_action_controller.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key, required this.dashboardController});

  final DashboardController dashboardController;

  final FloatingController floatingController = Get.put(FloatingController());

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      child: Scaffold(
        extendBody: true,
        backgroundColor: appScreenBackgroundDark,
        extendBodyBehindAppBar: true,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: Obx(
          () => IgnorePointer(
            ignoring: floatingController.isExpanded.value,
            child: dashboardController
                .screen[dashboardController.currentIndex.value],
          ),
        ),
        bottomNavigationBar: Obx(() {
          final currentIndex = dashboardController.currentIndex.value;
          final navItems = dashboardController.bottomNavItems;

          return Container(
            margin: const EdgeInsets.all(10),
            height: 65,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: appColorPrimary.withOpacity(0.6),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(navItems.length, (index) {
                final item = navItems[index];
                final isSelected = currentIndex == index;

                return GestureDetector(
                  onTap: () async {
                    hideKeyboard(context);
                    floatingController.isExpanded(false);
                    await dashboardController.onBottomTabChange(index);
                    dashboardController.currentIndex(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? appColorPrimary.withOpacity(0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          size: 20,
                          color: isSelected ? Colors.white : iconColor,
                        ),
                        if (isSelected) ...[
                          6.width,
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 60, // Maximum width for text
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget navigationBarItemWidget(BottomBarItem navBar, bool isCurrentTab) {
    return NavigationDestination(
      selectedIcon: Icon(navBar.activeIcon, color: appColorPrimary, size: 20),
      icon: Icon(navBar.icon, color: iconColor, size: 20),
      label: navBar.title,
    );
  }

  Future<void> handleChangeTabIndex(int index) async {
    dashboardController.currentIndex(index);
  }
}
