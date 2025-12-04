import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/live_tv/live_tv_details/live_tv_details_screen.dart';
import 'package:zatra_tv/screens/live_tv/model/live_tv_dashboard_response.dart';
import 'package:zatra_tv/screens/movie_list/movie_list_screen.dart';
import 'package:zatra_tv/screens/tv_show/tv_show_screen.dart';
import 'package:zatra_tv/screens/tv_show/tvshow_list_screen.dart';
import 'package:zatra_tv/screens/video/video_list_screen.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/generated/assets.dart';
import '../../../components/cached_image_widget.dart';
import '../../../utils/constants.dart';
import '../../movie_details/movie_details_screen.dart';
import '../../video/video_details_screen.dart';
import '../home_controller.dart';
import '../model/dashboard_res_model.dart';
import 'subscribe_card.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key, required this.homeScreenCont});

  final HomeController homeScreenCont;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final sliders = homeScreenCont.dashboardDetail.value.slider ?? [];

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: Get.height * 0.5,
                width: Get.width,
                child: sliders.isNotEmpty
                    ? PageView.builder(
                        controller: homeScreenCont.sliderPageController.value,
                        itemCount: sliders.length,
                        itemBuilder: (context, index) {
                          final data = sliders[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                              top: 120,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: appColorPrimary,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Stack(
                                  children: [
                                    // Background Image
                                    CachedImageWidget(
                                      url: data.bannerURL,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                      height: Get.height,
                                    ),

                                    // Neon Content
                                    Positioned(
                                      bottom: 10,
                                      right: 20,
                                      child:
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: appColorPrimary,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: CachedImageWidget(
                                              url: Assets.iconsIcPlay,
                                              height: 14,
                                              width: 14,
                                              color: Colors.white,
                                            ),
                                          ).onTap(() {
                                            _handleSliderTap(data);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : CachedImageWidget(
                        url: '',
                        height: Get.height * 0.7,
                        width: Get.width,
                      ),
              ),
              Positioned(
                top: 0,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CachedImageWidget(
                      url: Assets.iconsIcIcon,
                      height: 50,
                      width: 50,
                    ),
                    const Spacer(),
                    const SubscribeCard(),
                    12.width,
                  ],
                ),
              ),
              Positioned(
                top: 70,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RoundIconOutlinedButton(
                      text: locale.value.videos,
                      onPressed: () {
                        Get.to(() => VideoListScreen());
                      },
                    ),
                    12.width,
                    RoundIconOutlinedButton(
                      text: locale.value.movies,
                      onPressed: () {
                        Get.to(() => MovieListScreen());
                      },
                    ),
                    12.width,
                    RoundIconOutlinedButton(
                      text: locale.value.tVShows,
                      onPressed: () {
                        Get.to(() => TvShowListScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Dot Indicator
          if (sliders.length > 1 && homeScreenCont.isLoading.isFalse)
            DotIndicator(
              pageController: homeScreenCont.sliderPageController.value,
              pages: sliders,
              indicatorColor: white,
              unselectedIndicatorColor: darkGrayColor,
              currentBoxShape: BoxShape.rectangle,
              boxShape: BoxShape.rectangle,
              borderRadius: radius(3),
              currentBorderRadius: radius(3),
              currentDotSize: 6,
              currentDotWidth: 6,
              dotSize: 6,
            ),
          20.height,
        ],
      );
    });
  }

  void _handleSliderTap(SliderModel data) {
    if (data.type == VideoType.tvshow) {
      Get.to(() => TvShowScreen(), arguments: data.data);
    } else if (data.type == VideoType.liveTv) {
      Get.to(
        () => LiveShowDetailsScreen(),
        arguments: ChannelModel(id: data.data.id, name: data.data.name),
      );
    } else if (data.type == VideoType.movie) {
      Get.to(() => MovieDetailsScreen(), arguments: data.data);
    } else if (data.type == VideoType.video) {
      Get.to(() => VideoDetailsScreen(), arguments: data.data);
    }
  }
}

class RoundIconOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;

  const RoundIconOutlinedButton({
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 30,
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: appColorPrimary,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: appColorPrimary,
          side: BorderSide(color: appColorPrimary.withOpacity(0.6), width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
