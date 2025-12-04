import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/screens/download_videos/components/download_movie_card.dart';
import 'package:zatra_tv/screens/download_videos/download_controller.dart';
import 'package:zatra_tv/generated/assets.dart';
import 'package:zatra_tv/screens/download_videos/download_details/download_details_screen.dart';
import 'package:zatra_tv/video_players/model/video_model.dart';

import '../../components/app_scaffold.dart';
import '../../components/cached_image_widget.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/empty_error_state_widget.dart';

class DownloadVideosScreen extends StatelessWidget {
  DownloadVideosScreen({super.key});

  final DownloadController downloadVideoCont = Get.put(DownloadController());

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      isLoading: downloadVideoCont.isLoading,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      topBarBgColor: transparentColor,
      appBartitleText: locale.value.yourDownloads,
      actions: [
        Obx(
          () =>
              GestureDetector(
                    onTap: () {
                      downloadVideoCont.isDelete.value =
                          !downloadVideoCont.isDelete.value;
                      downloadVideoCont.selectedVideos.clear();
                    },
                    child: const CachedImageWidget(
                      url: Assets.iconsIcDelete,
                      height: 20,
                      width: 20,
                      color: appColorPrimary,
                    ),
                  )
                  .paddingSymmetric(horizontal: 16)
                  .visible(downloadVideoCont.movieDet.isNotEmpty),
        ),
      ],
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
          AnimatedListView(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: downloadVideoCont.movieDet.length,
            listAnimationType: ListAnimationType.FadeIn,
            emptyWidget: NoDataWidget(
              titleTextStyle: boldTextStyle(color: white),
              subTitleTextStyle: primaryTextStyle(color: white),
              title: locale.value.noDataFound,
              retryText: "",
              imageWidget: const EmptyStateWidget(),
            ).paddingSymmetric(horizontal: 16),
            itemBuilder: (context, index) {
              VideoPlayerModel poster = downloadVideoCont.movieDet[index];
              return Obx(
                () => Row(
                  children: [
                    if (downloadVideoCont.isDelete.value) 16.width,
                    if (downloadVideoCont.isDelete.value)
                      InkWell(
                        onTap: () {
                          if (downloadVideoCont.selectedVideos.contains(
                            poster,
                          )) {
                            downloadVideoCont.selectedVideos.remove(poster);
                          } else {
                            downloadVideoCont.selectedVideos.add(poster);
                          }
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: boxDecorationDefault(
                            color:
                                downloadVideoCont.selectedVideos.contains(
                                  poster,
                                )
                                ? appColorPrimary
                                : context.cardColor,
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(
                              color:
                                  downloadVideoCont.selectedVideos.contains(
                                    poster,
                                  )
                                  ? appColorPrimary
                                  : borderColor,
                            ),
                          ),
                          alignment: Alignment.center,
                          child:
                              downloadVideoCont.selectedVideos.contains(poster)
                              ? const Icon(Icons.check, size: 12, color: white)
                              : null,
                        ),
                      ),
                    InkWell(
                      onLongPress: () {
                        if (downloadVideoCont.isDelete.value) {
                          if (downloadVideoCont.selectedVideos.contains(
                            poster,
                          )) {
                            downloadVideoCont.selectedVideos.remove(poster);
                          } else {
                            downloadVideoCont.selectedVideos.add(poster);
                          }
                        } else {
                          downloadVideoCont.isDelete(true);
                        }
                      },
                      onTap: () {
                        if (downloadVideoCont.isDelete.value) {
                          if (downloadVideoCont.selectedVideos.contains(
                            poster,
                          )) {
                            downloadVideoCont.selectedVideos.remove(poster);
                          } else {
                            downloadVideoCont.selectedVideos.add(poster);
                          }
                        } else {
                          Get.to(
                            () => DownloadDetailsScreen(
                              movieDetails: downloadVideoCont.movieDet[index],
                              downloadVideoCont: downloadVideoCont,
                            ),
                          );
                        }
                      },
                      child: DownloadMovieCard(movieDetails: poster)
                          .paddingOnly(
                            left: downloadVideoCont.isDelete.isTrue ? 22 : 16,
                            right: 16,
                          ),
                    ).expand(),
                  ],
                ).paddingSymmetric(vertical: 8),
              );
            },
          ),
        ],
      ),
      widgetsStackedOverBody: [
        Obx(
          () => downloadVideoCont.isDelete.isTrue
              ? Positioned(
                  bottom: 26,
                  left: 8,
                  right: 8,
                  child: AppButton(
                    width: double.infinity,
                    text: locale.value.delete,
                    color: downloadVideoCont.selectedVideos.isNotEmpty
                        ? appColorPrimary
                        : btnColor,
                    enabled: downloadVideoCont.selectedVideos.isNotEmpty,
                    disabledColor: btnColor,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: radius(6),
                    ),
                    textStyle: appButtonTextStyleWhite.copyWith(
                      color: downloadVideoCont.selectedVideos.isNotEmpty
                          ? white
                          : darkGrayTextColor,
                    ),
                    onTap: () {
                      downloadVideoCont.handleRemoveFromDownload(context);
                    },
                  ),
                )
              : const Offstage(),
        ),
      ],
    );
  }
}
