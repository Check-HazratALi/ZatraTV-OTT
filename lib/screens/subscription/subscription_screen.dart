import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:zatra_tv/screens/profile/components/subscription_component.dart';
import 'package:zatra_tv/screens/subscription/shimmer_subscription_list.dart';
import 'package:zatra_tv/screens/subscription/subscription_controller.dart';
// import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/generated/assets.dart';

import '../../components/app_scaffold.dart';
import '../../components/cached_image_widget.dart';
import '../../main.dart';
import '../../utils/empty_error_state_widget.dart';
import 'components/subscription_list/subscription_list_component.dart';
import 'components/subscription_price_component.dart';

class SubscriptionScreen extends StatelessWidget {
  final bool launchDashboard;

  SubscriptionScreen({super.key, required this.launchDashboard});

  final SubscriptionController subscriptionCont = Get.put(
    SubscriptionController(),
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasLeadingWidget: true,
      isLoading: false.obs,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      appBarTitle: CachedImageWidget(
        url: Assets.iconsIcIcon,
        height: 50,
        width: 50,
      ),
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
          RefreshIndicator(
            color: appColorPrimary,
            onRefresh: () async {
              return await subscriptionCont.getSubscriptionDetails();
            },
            child: Obx(
              () => SnapHelperWidget(
                future: subscriptionCont.getSubscriptionFuture.value,
                loadingWidget: subscriptionCont.isLoading.value
                    ? const ShimmerSubscriptionList()
                    : const ShimmerSubscriptionList(),
                errorBuilder: (error) {
                  return NoDataWidget(
                    titleTextStyle: secondaryTextStyle(color: white),
                    subTitleTextStyle: primaryTextStyle(color: white),
                    title: error,
                    retryText: locale.value.reload,
                    imageWidget: const ErrorStateWidget(),
                    onRetry: () {
                      subscriptionCont.getSubscriptionDetails();
                    },
                  );
                },
                onSuccess: (res) {
                  return AnimatedScrollView(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    padding: EdgeInsets.only(bottom: 30),
                    refreshIndicatorColor: appColorPrimary,
                    children: [
                      16.height,
                      if (subscriptionCont.planList.isEmpty &&
                          !subscriptionCont.isLoading.value)
                        NoDataWidget(
                          titleTextStyle: boldTextStyle(color: white),
                          subTitleTextStyle: primaryTextStyle(color: white),
                          title: locale.value.noDataFound,
                          retryText: "",
                          imageWidget: const EmptyStateWidget(),
                        ).paddingSymmetric(horizontal: 16)
                      else
                        SubscriptionListComponent(
                              planList: subscriptionCont.planList,
                              subscriptionController: subscriptionCont,
                            )
                            .paddingBottom(16)
                            .visible(!subscriptionCont.isLoading.value),
                    ],
                  ).paddingSymmetric(horizontal: 16);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavBar: Obx(
        () => PriceComponent(
          launchDashboard: launchDashboard,
          subscriptionCont: subscriptionCont,
        ).visible(subscriptionCont.selectPlan.value.name.isNotEmpty),
      ),
    );
  }
}
