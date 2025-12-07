import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_chrome_cast/_discovery_manager/discovery_manager.dart';
import 'package:flutter_chrome_cast/_session_manager/cast_session_manager.dart';
import 'package:flutter_chrome_cast/entities/cast_session.dart';
import 'package:flutter_chrome_cast/enums/connection_state.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/ads/components/custom_ad_component.dart';
import 'package:zatra_tv/components/loader_widget.dart';
import 'package:zatra_tv/generated/assets.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/tv_show/components/tv_show_season_component.dart';

import '../../../components/custom_icon_button_widget.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../auth/sign_in/sign_in_screen.dart';
import '../../movie_details/components/actor_component.dart';
import '../../movie_details/components/add_review/add_review_component.dart';
import '../../movie_details/components/more_list/more_list_component.dart';
import '../../movie_details/components/review_list/review_list_component.dart';
import '../../review_list/components/remove_review_component.dart';
import '../tv_show_controller.dart';

class TvShowDetailsComponent extends StatelessWidget {
  TvShowDetailsComponent({super.key});

  final TvShowController showDetailCont = Get.put(TvShowController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          16.height,
          _buildStatsRow(context),
          ...showDetailCont.isTrailer.isTrue
              ? [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        icon: Assets.iconsIcPlus,
                        title: locale.value.watchlist,
                        iconHeight: 22,
                        iconWidth: 22,
                        onTap: () {
                          if (isLoggedIn.isTrue) {
                            showDetailCont.saveWatchList(
                              addToWatchList: !showDetailCont
                                  .tvShowDetail
                                  .value
                                  .isWatchList,
                            );
                          } else {
                            LiveStream().emit(podPlayerPauseKey);
                            Get.to(() => SignInScreen())?.then((value) {
                              if (isLoggedIn.isTrue) {
                                showDetailCont.saveWatchList(
                                  addToWatchList: !showDetailCont
                                      .tvShowDetail
                                      .value
                                      .isWatchList,
                                );
                              }
                            });
                          }
                        },
                        isTrue: showDetailCont.tvShowDetail.value.isWatchList,
                        checkIcon: Assets.iconsIcCheck,
                      ),
                      CustomIconButton(
                        icon: Assets.iconsIcShare,
                        title: locale.value.share,
                        onTap: () {
                          shareVideo(
                            type: showDetailCont.tvShowDetail.value.type,
                            videoId: showDetailCont.tvShowDetail.value.id,
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: Assets.iconsIcThumbsup,
                        title: locale.value.like,
                        onTap: () {
                          if (isLoggedIn.isTrue) {
                            showDetailCont.addLike();
                          } else {
                            Get.to(() => SignInScreen())?.then((value) {
                              if (isLoggedIn.isTrue) {
                                showDetailCont.addLike();
                              }
                            });
                          }
                        },
                        isTrue: showDetailCont.tvShowDetail.value.isLiked,
                        checkIcon: Assets.iconsIcLike,
                      ),
                      // CustomIconButton(
                      //   icon: Assets.iconsIcPictureInPicture,
                      //   title: locale.value.pip,
                      //   color: iconColor,
                      //   onTap: () async {
                      //     /// Handle Picture In Picture Mode
                      //     handlePip(
                      //         controller: showDetailCont, context: context);
                      //   },
                      // ),
                      Obx(() {
                        if (isCastingAvailable.value) {
                          return StreamBuilder<GoogleCastSession?>(
                            stream: GoogleCastSessionManager
                                .instance
                                .currentSessionStream,
                            builder: (context, snapshot) {
                              final bool isConnected =
                                  GoogleCastSessionManager
                                      .instance
                                      .connectionState ==
                                  GoogleCastConnectState.connected;
                              return CustomIconButton(
                                icon: '',
                                title: locale.value.videoCast,
                                titleTextStyle: !checkCastSupport()
                                    ? secondaryTextStyle(size: 14, color: grey)
                                    : null,
                                iconWidget: Icon(
                                  isConnected
                                      ? Icons.cast_connected
                                      : Icons.cast,
                                  size: 20,
                                  color: !checkCastSupport() ? grey : white,
                                ),
                                onTap: () {
                                  if (!checkCastSupport()) {
                                    toast(locale.value.castSupportInfo);
                                    return;
                                  }
                                  doIfLogin(
                                    onLoggedIn: () {
                                      checkCastSupported(
                                        onCastSupported: () {
                                          if (isConnected) {
                                            GoogleCastDiscoveryManager.instance
                                                .stopDiscovery();
                                            GoogleCastSessionManager.instance
                                                .endSessionAndStopCasting();
                                          } else {
                                            LiveStream().emit(
                                              podPlayerPauseKey,
                                            );
                                            showDetailCont
                                                .openBottomSheetForFCCastAvailableDevices(
                                                  context,
                                                );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return Offstage();
                        }
                      }),
                    ],
                  ).paddingSymmetric(vertical: 16, horizontal: 2),
                  TvShowSeasonComponent().paddingSymmetric(horizontal: 10),
                  ActorComponent(
                    castDetails: showDetailCont.tvShowDetail.value.casts,
                    title: locale.value.cast,
                  ).visible(showDetailCont.tvShowDetail.value.casts.isNotEmpty),
                  ActorComponent(
                    castDetails: showDetailCont.tvShowDetail.value.directors,
                    title: locale.value.directors,
                  ).visible(
                    showDetailCont.tvShowDetail.value.directors.isNotEmpty,
                  ),
                  Obx(() {
                    final ads = getDashboardController()
                        .getBannerAdsForCategory(
                          targetContentType: 'tvshow',
                          categoryId: showDetailCont.selectedEpisode.value.id,
                        );
                    if (ads.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return CustomAdComponent(ads: ads);
                  }),
                  AddReviewComponent(
                    isMovie: false,
                    editReviewCallback: () {
                      showDetailCont.editReview();
                    },
                    deleteReviewCallback: () {
                      LiveStream().emit(podPlayerPauseKey);
                      Get.bottomSheet(
                        isDismissible: true,
                        isScrollControlled: false,
                        enableDrag: false,
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: RemoveReviewComponent(
                            onRemoveTap: () {
                              Get.back();
                              showDetailCont.deleteReview();
                            },
                          ),
                        ),
                      );
                    },
                  ).visible(isLoggedIn.isTrue),
                  ReviewListComponent(
                    reviewList: showDetailCont.tvShowDetail.value.reviews,
                    movieName: showDetailCont.tvShowDetail.value.name,
                    movieId: showDetailCont.tvShowDetail.value.id,
                    isMovie: false,
                  ).visible(
                    showDetailCont.tvShowDetail.value.reviews.isNotEmpty,
                  ),
                  MoreListComponent(
                    moreList: showDetailCont.tvShowDetail.value.moreItems,
                  ).visible(
                    showDetailCont.tvShowDetail.value.moreItems.isNotEmpty,
                  ),
                ]
              : [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        icon: Assets.iconsIcShare,
                        title: locale.value.share,
                        onTap: () {
                          LiveStream().emit(podPlayerPauseKey);
                          shareVideo(
                            type: VideoType.episode,
                            videoId: showDetailCont.selectedEpisode.value.id,
                          );
                        },
                      ),
                      if (showDetailCont.showDownload.value)
                        CustomIconButton(
                          buttonColor: Colors.transparent,
                          icon: showDetailCont.isDownloaded.value
                              ? Assets.iconsIcDownloaded
                              : Assets.iconsIcDownload,
                          title: locale.value.download,
                          isTrue: showDetailCont.isDownloaded.value,
                          iconWidget:
                              showDetailCont.downloadPercentage.value >= 1 &&
                                      showDetailCont.downloadPercentage.value <
                                          100 ||
                                  showDetailCont.isDownloading.value
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    LoaderWidget(
                                      size: 30,
                                      loaderColor: appColorPrimary,
                                    ),
                                    if (showDetailCont
                                            .downloadPercentage
                                            .value >
                                        0)
                                      Marquee(
                                        child: Text(
                                          '${showDetailCont.downloadPercentage.value}'
                                              .suffixText(value: '%'),
                                          style: primaryTextStyle(
                                            color: appColorPrimary,
                                            size: 10,
                                          ),
                                        ),
                                      ),
                                  ],
                                )
                              : null,
                          color: iconColor,
                          onTap: () {
                            if (showDetailCont.isDownloaded.value ||
                                showDetailCont
                                        .selectedEpisode
                                        .value
                                        .requiredPlanLevel ==
                                    0) {
                              showDetailCont.handleDownloads(context);
                            } else {
                              onSubscriptionLoginCheck(
                                videoAccess:
                                    showDetailCont.selectedEpisode.value.access,
                                callBack: () {
                                  if (currentSubscription.value.level >=
                                      showDetailCont
                                          .selectedEpisode
                                          .value
                                          .requiredPlanLevel) {
                                    showDetailCont.handleDownloads(context);
                                  }
                                },
                                planId:
                                    showDetailCont.selectedEpisode.value.planId,
                                planLevel: showDetailCont
                                    .selectedEpisode
                                    .value
                                    .requiredPlanLevel,
                              );
                            }
                          },
                        ),
                      // CustomIconButton(
                      //   icon: Assets.iconsIcPictureInPicture,
                      //   title: locale.value.pip,
                      //   color: iconColor,
                      //   onTap: () async {
                      //     /// Handle Picture In Picture Mode
                      //     handlePip(
                      //         controller: showDetailCont, context: context);
                      //   },
                      // ),
                      Obx(() {
                        if (isCastingAvailable.value) {
                          return StreamBuilder<GoogleCastSession?>(
                            stream: GoogleCastSessionManager
                                .instance
                                .currentSessionStream,
                            builder: (context, snapshot) {
                              final bool isConnected =
                                  GoogleCastSessionManager
                                      .instance
                                      .connectionState ==
                                  GoogleCastConnectState.connected;
                              return CustomIconButton(
                                icon: '',
                                title: locale.value.videoCast,
                                titleTextStyle: !checkCastSupport()
                                    ? secondaryTextStyle(size: 14, color: grey)
                                    : null,
                                iconWidget: Icon(
                                  isConnected
                                      ? Icons.cast_connected
                                      : Icons.cast,
                                  size: 20,
                                  color: !checkCastSupport() ? grey : white,
                                ),
                                onTap: () {
                                  if (!checkCastSupport()) {
                                    toast(locale.value.castSupportInfo);
                                    return;
                                  }
                                  doIfLogin(
                                    onLoggedIn: () {
                                      checkCastSupported(
                                        onCastSupported: () {
                                          if (isConnected) {
                                            GoogleCastDiscoveryManager.instance
                                                .stopDiscovery();
                                            GoogleCastSessionManager.instance
                                                .endSessionAndStopCasting();
                                          } else {
                                            LiveStream().emit(
                                              podPlayerPauseKey,
                                            );
                                            showDetailCont
                                                .openBottomSheetForFCCastAvailableDevices(
                                                  context,
                                                );
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return Offstage();
                        }
                      }),
                    ],
                  ).paddingSymmetric(vertical: 16, horizontal: 2),
                  Obx(() {
                    final ads = getDashboardController()
                        .getBannerAdsForCategory(
                          targetContentType: 'tvshow',
                          categoryId: showDetailCont.selectedEpisode.value.id,
                        );
                    if (ads.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return CustomAdComponent(ads: ads);
                  }),
                  TvShowSeasonComponent().paddingSymmetric(horizontal: 10),
                  MoreListComponent(
                    moreList: showDetailCont.tvShowDetail.value.moreItems,
                  ).visible(
                    showDetailCont.tvShowDetail.value.moreItems.isNotEmpty,
                  ),
                ],
        ],
      );
    });
  }

  Widget _buildStatsRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: boxDecorationDefault(
        color: appColorPrimary.withOpacity(0.1),
        borderRadius: radius(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Likes
          _buildStatItem(
            icon: Icons.thumb_up_outlined,
            value: (showDetailCont.tvShowDetail.value.totalLikes ?? 0)
                .formatNumber(),
            label: "Likes",
            color: appColorPrimary,
          ),

          // Views
          _buildStatItem(
            icon: Icons.remove_red_eye_outlined,
            value: (showDetailCont.tvShowDetail.value.totalViews ?? 0)
                .formatNumber(),
            label: "Views",
            color: Colors.blue,
          ),
        ],
      ),
    ).paddingOnly(bottom: 8);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 20),
        SizedBox(height: 4),
        Text(
          value,
          style: boldTextStyle(size: 14, color: textPrimaryColorGlobal),
        ),
        Text(
          label,
          style: secondaryTextStyle(size: 12, color: textSecondaryColorGlobal),
        ),
      ],
    );
  }

  bool checkCastSupport() {
    if (showDetailCont.showData.value.videoUploadType.toLowerCase() ==
            PlayerTypes.hls.toLowerCase() ||
        showDetailCont.showData.value.videoUploadType.toLowerCase() ==
            PlayerTypes.url.toLowerCase() ||
        showDetailCont.showData.value.videoUploadType.toLowerCase() ==
            PlayerTypes.local.toLowerCase()) {
      return true;
    } else {
      return false;
    }
  }
}
