import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/screens/subscription/subscription_screen.dart';
import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/common_base.dart';
import '../../../main.dart';
import '../../subscription/model/subscription_plan_model.dart';

class SubscriptionComponent extends StatelessWidget {
  final SubscriptionPlanModel planDetails;
  final VoidCallback? callback;

  const SubscriptionComponent({
    super.key,
    this.callback,
    required this.planDetails,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = planDetails.status == "active";
    final bool hasExpired =
        planDetails.endDate.isNotEmpty &&
        DateTime.now().isAfter(DateTime.parse(planDetails.endDate));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.withOpacity(0.15),
                  Colors.teal.withOpacity(0.1),
                ],
              )
            : LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.orange.withOpacity(0.15),
                  Colors.amber.withOpacity(0.1),
                ],
              ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? Colors.green.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.to(() => SubscriptionScreen(launchDashboard: false))?.then((
              value,
            ) {
              if (planDetails.level != currentSubscription.value.level) {
                callback?.call();
              }
            });
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Header Section
                Row(
                  children: [
                    // Plan Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isActive
                                ? planDetails.name.validate()
                                : "Upgrade Now",
                            style: boldTextStyle(size: 16, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          4.height,
                          if (isActive && planDetails.endDate.isNotEmpty)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: hasExpired
                                      ? Colors.red
                                      : Colors.white70,
                                ),
                                6.width,
                                Flexible(
                                  child: Text(
                                    hasExpired
                                        ? "Expired On ${dateFormat(planDetails.endDate)}"
                                        : "Expiring On ${dateFormat(planDetails.endDate)}",
                                    style: secondaryTextStyle(
                                      size: 13,
                                      color: hasExpired
                                          ? Colors.red
                                          : Colors.white70,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          else if (!isActive)
                            Row(
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 14,
                                  color: Colors.orange,
                                ),
                                6.width,
                                Text(
                                  "Unlock Premium Features",
                                  style: secondaryTextStyle(
                                    size: 13,
                                    color: Colors.white70,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.green.withOpacity(0.2)
                            : Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isActive ? Colors.green : Colors.orange,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        isActive ? locale.value.active : locale.value.free,
                        style: boldTextStyle(
                          size: 12,
                          color: isActive ? Colors.green : Colors.orange,
                        ),
                      ),
                    ),
                  ],
                ),

                10.height,

                // Features Preview
                if (!isActive)
                  Column(
                    children: [
                      Row(
                        children: [
                          _buildFeaturePreview(
                            icon: Icons.movie_filter,
                            text: "Unlimited Movies",
                          ),
                          12.width,
                          _buildFeaturePreview(
                            icon: Icons.tv,
                            text: "TV Shows",
                          ),
                          // 12.width,
                          // _buildFeaturePreview(
                          //   icon: Icons.download,
                          //   text: "Download",
                          // ),
                          _buildFeaturePreview(
                            icon: Icons.devices,
                            text: "Multi Device",
                          ),
                        ],
                      ),
                      // 8.height,
                      // Row(
                      //   children: [
                      //     _buildFeaturePreview(
                      //       icon: Icons.ads_click,
                      //       text: "No Ads",
                      //     ),
                      //     12.width,
                      //     _buildFeaturePreview(
                      //       icon: Icons.high_quality,
                      //       text: "HD Quality",
                      //     ),
                      //     12.width,
                      //     _buildFeaturePreview(
                      //       icon: Icons.devices,
                      //       text: "Multi Device",
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),

                20.height,

                // Action Button
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isActive
                          ? [Colors.green, Colors.teal.shade600]
                          : [Colors.orange, Colors.amber.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (isActive ? Colors.green : Colors.orange)
                            .withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isActive
                            ? hasExpired
                                  ? "Renew Now"
                                  : "Manage Plan"
                            : "Get Started",
                        style: boldTextStyle(size: 16, color: Colors.white),
                      ),
                      8.width,
                      Icon(
                        isActive
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_forward_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ).onTap(() {
                  Get.to(
                    () => SubscriptionScreen(launchDashboard: false),
                  )?.then((value) {
                    if (planDetails.level != currentSubscription.value.level) {
                      callback?.call();
                    }
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturePreview({required IconData icon, required String text}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: Colors.orange),
            4.height,
            Text(
              text,
              style: secondaryTextStyle(size: 10, color: Colors.white70),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
