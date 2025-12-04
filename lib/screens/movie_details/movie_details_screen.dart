import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/screens/movie_details/movie_details_controller.dart';
import 'package:zatra_tv/screens/movie_details/movie_details_shimmer_screen.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/utils/constants.dart';

import '../../components/app_scaffold.dart';
import '../../main.dart';
import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../utils/empty_error_state_widget.dart';
import '../../video_players/video_player.dart';
import 'components/movie_details_component.dart';

class MovieDetailsScreen extends StatelessWidget {
  final bool isFromContinueWatch;

  MovieDetailsScreen({super.key, this.isFromContinueWatch = false});

  final MovieDetailsController movieDetCont = Get.put(MovieDetailsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      hasLeadingWidget: true,
      isLoading: movieDetCont.isLoading,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      topBarBgColor: Colors.transparent,
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
              return await movieDetCont.getMovieDetail();
            },
            child: Obx(() {
              return AnimatedScrollView(
                crossAxisAlignment: CrossAxisAlignment.start,
                physics: isPipModeOn.value
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                refreshIndicatorColor: appColorPrimary,
                padding: EdgeInsets.only(bottom: 30),
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    child: VideoPlayersComponent(
                      key: ValueKey(movieDetCont.movieData.value.id),
                      isTrailer:
                          movieDetCont.isTrailer.value && !isFromContinueWatch,
                      videoModel: getVideoPlayerResp(
                        movieDetCont.movieData.value.toJson(),
                      ),
                      isPipMode: isPipModeOn.value,
                      showWatchNow: movieDetCont.isTrailer.value,
                      onWatchNow: () {
                        movieDetCont.isTrailer(false);
                        movieDetCont.storeView();
                        playMovie(
                          continueWatchDuration:
                              movieDetCont.movieDetailsResp.value.watchedTime,
                          newURL: movieDetCont.movieData.value.videoUrlInput,
                          urlType: movieDetCont.movieData.value.videoUploadType,
                          videoType: VideoType.movie,
                          isWatchVideo: true,
                        );
                      },
                    ),
                  ),
                  if (!isPipModeOn.value)
                    SnapHelperWidget(
                      future: movieDetCont.getMovieDetailsFuture.value,
                      loadingWidget: movieDetCont.isLoading.isFalse
                          ? MovieDetailsShimmerScreen()
                          : Offstage(),
                      errorBuilder: (error) {
                        return NoDataWidget(
                          titleTextStyle: secondaryTextStyle(color: white),
                          subTitleTextStyle: primaryTextStyle(color: white),
                          title: error,
                          retryText: locale.value.reload,
                          imageWidget: const ErrorStateWidget(),
                          onRetry: () {
                            movieDetCont.getMovieDetail();
                          },
                        ).visible(movieDetCont.isLoading.isFalse);
                      },
                      onSuccess: (res) {
                        return MovieDetailsComponent(
                          movieDetCont: movieDetCont,
                        );
                      },
                    ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
