import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/components/shimmer_widget.dart';
import 'package:zatra_tv/generated/assets.dart';
import 'package:zatra_tv/screens/video/video_details_screen.dart';
import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/utils/common_base.dart';

import '../../../main.dart';
import '../../../screens/coming_soon/coming_soon_controller.dart';
import '../../../screens/coming_soon/coming_soon_detail_screen.dart';
import '../../../screens/coming_soon/model/coming_soon_response.dart';
import '../../../screens/live_tv/live_tv_details/live_tv_details_screen.dart';
import '../../../screens/live_tv/model/live_tv_dashboard_response.dart';
import '../../../screens/movie_details/movie_details_screen.dart';
import '../../../screens/tv_show/tv_show_screen.dart';
import '../../../utils/constants.dart';
import '../../../video_players/model/video_model.dart';
import '../../cached_image_widget.dart';

class PosterCardComponent extends StatelessWidget {
  final VideoPlayerModel posterDetail;
  final double? height;
  final double? width;
  final bool isTop10;
  final bool isHorizontalList;
  final bool isSearch;
  final bool isLoading;
  final bool isTopChannel;

  final VoidCallback? onTap;

  const PosterCardComponent({
    super.key,
    required this.posterDetail,
    this.isTop10 = false,
    this.height,
    this.width,
    this.isHorizontalList = true,
    this.isLoading = false,
    this.isSearch = false,
    this.isTopChannel = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap:
          onTap ??
          () {
            if (isLoading) return;
            if (posterDetail.releaseDate.isNotEmpty &&
                isComingSoon(posterDetail.releaseDate)) {
              ComingSoonController comingSoonCont = Get.put(
                ComingSoonController(),
              );
              Get.to(
                () => ComingSoonDetailScreen(
                  comingSoonCont: comingSoonCont,
                  comingSoonData: ComingSoonModel.fromJson(
                    posterDetail.toJson(),
                  ),
                ),
              );
            } else {
              if (isTopChannel) {
                Get.to(
                  () => LiveShowDetailsScreen(),
                  arguments: ChannelModel(
                    id: posterDetail.id,
                    name: posterDetail.name,
                    serverUrl: posterDetail.serverUrl,
                    streamType: posterDetail.streamType,
                    requiredPlanLevel: posterDetail.requiredPlanLevel,
                    access: posterDetail.access,
                  ),
                );
              } else {
                if (posterDetail.type == VideoType.movie) {
                  Get.to(() => MovieDetailsScreen(), arguments: posterDetail);
                } else if (posterDetail.type == VideoType.tvshow ||
                    posterDetail.type == VideoType.episode) {
                  Get.to(() => TvShowScreen(), arguments: posterDetail);
                } else if (posterDetail.type == VideoType.video) {
                  Get.to(() => VideoDetailsScreen(), arguments: posterDetail);
                }
              }
            }
          },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              if (isLoading)
                ShimmerWidget(
                  height: isTop10 ? 150 : height ?? double.infinity,
                  width:
                      width ??
                      (isSearch ? Get.width * 0.28 : Get.width / 3 - 24),
                  radius: 12,
                )
              else
                CachedImageWidget(
                  url: posterDetail.posterImage,
                  height: isTop10 ? 150 : height ?? double.infinity,
                  width: width ?? (isSearch ? Get.width * 0.28 : 110),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              if (posterDetail.planId != 0)
                if ((posterDetail.movieAccess == MovieAccess.paidAccess ||
                        posterDetail.access == MovieAccess.paidAccess) &&
                    isMoviePaid(
                      requiredPlanLevel: posterDetail.requiredPlanLevel,
                    ))
                  Positioned(
                    top: 4,
                    left: 5,
                    child: Container(
                      height: isHorizontalList && !isSearch ? 20 : 16,
                      width: isHorizontalList && !isSearch ? 20 : 16,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: yellowColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: const CachedImageWidget(url: Assets.iconsIcVector),
                    ),
                  ),
              if (posterDetail.movieAccess == MovieAccess.payPerView)
                Positioned(
                  top: 4,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: rentedColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      spacing: 4,
                      children: [
                        const CachedImageWidget(
                          url: Assets.iconsIcRent,
                          height: 8,
                          width: 8,
                          color: Colors.white,
                        ),
                        Text(
                          posterDetail.isPurchased == true
                              ? locale.value.rented
                              : locale.value.rent,
                          style: secondaryTextStyle(color: white, size: 10),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
