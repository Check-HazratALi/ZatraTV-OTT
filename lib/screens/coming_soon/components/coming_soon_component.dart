import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/screens/coming_soon/model/coming_soon_response.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/utils/common_base.dart';
import 'package:zatra_tv/generated/assets.dart';

import '../../../components/cached_image_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../coming_soon_controller.dart';
import '../coming_soon_detail_screen.dart';

class ComingSoonComponent extends StatelessWidget {
  final ComingSoonModel comingSoonDet;
  final ComingSoonController comingSoonCont;
  final bool isLoading;
  final VoidCallback onRemindMeTap;

  const ComingSoonComponent({
    super.key,
    required this.comingSoonDet,
    required this.onRemindMeTap,
    this.isLoading = false,
    required this.comingSoonCont,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        comingSoonCont.comingSoonData(comingSoonDet);
        Get.to(
          () => ComingSoonDetailScreen(
            comingSoonCont: comingSoonCont,
            comingSoonData: comingSoonDet,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Section
            Stack(
              children: [
                Container(
                  height: 180,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(comingSoonDet.thumbnailImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: CachedImageWidget(
                    fit: BoxFit.cover,
                    url: comingSoonDet.thumbnailImage,
                    height: 180,
                    width: Get.width,
                  ),
                ),

                // Gradient Overlay
                Container(
                  height: 180,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),

                // Badges
                Positioned(
                  top: 12,
                  left: 12,
                  child: Row(
                    children: [
                      // Trailer Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: appColorPrimary.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: appColorPrimary.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        child: Text(
                          locale.value.trailer,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      8.width,

                      // Release Date Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          dateFormat(comingSoonDet.releaseDate),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Age Restriction Badge
                if (comingSoonDet.isRestricted)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        "${locale.value.ua18}+",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Content Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Genre Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Genre
                            if (comingSoonDet.genres.validate().isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: appColorPrimary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: appColorPrimary.withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  comingSoonDet.genre.validate(),
                                  style: TextStyle(
                                    color: appColorPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            8.height,

                            // Title
                            Text(
                              comingSoonDet.name.validate(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      16.width,

                      // Remind Me Button
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient:
                                  comingSoonDet.isRemind.getBoolInt() &&
                                      !isLoading
                                  ? LinearGradient(
                                      colors: [
                                        appColorPrimary,
                                        appColorSecondary,
                                      ],
                                    )
                                  : null,
                              color:
                                  comingSoonDet.isRemind.getBoolInt() &&
                                      !isLoading
                                  ? null
                                  : Colors.white.withOpacity(0.1),
                              border: Border.all(
                                color:
                                    comingSoonDet.isRemind.getBoolInt() &&
                                        !isLoading
                                    ? appColorPrimary.withOpacity(0.5)
                                    : Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                              boxShadow:
                                  comingSoonDet.isRemind.getBoolInt() &&
                                      !isLoading
                                  ? [
                                      BoxShadow(
                                        color: appColorPrimary.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                getRemindIcon(),
                                8.width,
                                Text(
                                  comingSoonDet.isRemind.getBoolInt()
                                      ? locale.value.remind
                                      : locale.value.remindMe,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: comingSoonDet.isRemind.getBoolInt()
                                        ? Colors.white
                                        : Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ).onTap(
                            onRemindMeTap,
                            splashColor: Colors.transparent,
                          ),
                        ],
                      ),
                    ],
                  ),
                  16.height,

                  // Metadata Row
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // Season Name
                        if (comingSoonDet.seasonName.toString().isNotEmpty)
                          Row(
                            children: [
                              Icon(
                                Icons.tv_rounded,
                                size: 14,
                                color: Colors.white70,
                              ),
                              6.width,
                              Text(
                                comingSoonDet.seasonName,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                        if (comingSoonDet.seasonName.toString().isNotEmpty)
                          16.width,

                        // Language
                        Row(
                          children: [
                            Icon(
                              Icons.language_rounded,
                              size: 14,
                              color: Colors.white70,
                            ),
                            6.width,
                            Text(
                              comingSoonDet.language.capitalizeFirstLetter(),
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  16.height,

                  // Description
                  if (comingSoonDet.description.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.description_outlined,
                                size: 14,
                                color: Colors.white70,
                              ),
                              8.width,
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          8.height,
                          readMoreTextWidget(
                            comingSoonDet.description,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRemindIcon() {
    try {
      return Lottie.asset(
        Assets.lottieRemind,
        height: 20,
        width: 20,
        repeat: comingSoonDet.isRemind.getBoolInt() ? false : true,
      );
    } catch (e) {
      return Icon(
        comingSoonDet.isRemind.getBoolInt()
            ? Icons.notifications_active_rounded
            : Icons.notifications_none_rounded,
        size: 18,
        color: comingSoonDet.isRemind.getBoolInt()
            ? Colors.white
            : Colors.white70,
      );
    }
  }
}
