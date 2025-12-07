import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/generated/assets.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../main.dart';

class RemoveContinueWatchingComponent extends StatelessWidget {
  final VoidCallback onRemoveTap;

  const RemoveContinueWatchingComponent({super.key, required this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: appScreenBackgroundDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Warning Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: CachedImageWidget(
                url: Assets.iconsIcDelete,
                height: 73,
                width: 100,
                color: appColorPrimary,
              ),
            ),

            24.height,

            // Title
            Text(
              locale.value.removeFromContinueWatch,
              style: boldTextStyle(size: 20, color: white),
              textAlign: TextAlign.center,
            ),

            32.height,

            // Buttons Row
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[700]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        locale.value.no.capitalizeFirstLetter(),
                        style: boldTextStyle(size: 16, color: white),
                      ),
                    ),
                  ),
                ),

                16.width,

                // Remove Button
                Expanded(
                  child: SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      onPressed: onRemoveTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        locale.value.yes.capitalizeFirstLetter(),
                        style: boldTextStyle(size: 16, color: white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
