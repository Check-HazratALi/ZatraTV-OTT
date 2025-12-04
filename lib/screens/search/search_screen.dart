import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/search/components/search_text_field.dart';
import 'package:zatra_tv/screens/search/shimmer_search.dart';

import '../../components/app_scaffold.dart';
import '../../utils/colors.dart';
import 'components/horizontal_card_list_component.dart';
import 'components/search_component.dart';
import 'components/show_list/search_list_component.dart';
import 'search_controller.dart';

class SearchScreen extends StatelessWidget {
  final SearchScreenController searchCont;

  const SearchScreen({super.key, required this.searchCont});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldNew(
      hasLeadingWidget: false,
      isLoading: searchCont.isLoading,
      hideAppBar: true,
      scaffoldBackgroundColor: appScreenBackgroundDark,
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
          Column(
            children: [
              // Fixed Height Header (Non-scrollable)
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    20.height,
                    Text(
                      "Search Content",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    8.height,
                    Text(
                      "Find movies, shows and more",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    20.height,
                    SearchTextFieldComponent(),
                    20.height,
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),

              // Scrollable Content Area
              Expanded(
                child: Obx(
                  () => SnapHelperWidget(
                    future: searchCont.getSearchMovieFuture.value,
                    loadingWidget: const ShimmerSearch(),
                    errorBuilder: (error) {
                      return SingleChildScrollView(
                        child: Container(
                          height: Get.height * 0.7,
                          child: Center(
                            child: NoDataWidget(
                              titleTextStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              subTitleTextStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                              title: error,
                              retryText: locale.value.reload,
                              imageWidget: Container(
                                padding: EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: Icon(
                                  Icons.error_outline_rounded,
                                  size: 50,
                                  color: Colors.white70,
                                ),
                              ),
                              onRetry: () {
                                searchCont.getSearchMovieDetail(
                                  showLoader: true,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    onSuccess: (res) {
                      return Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                appScreenBackgroundDark,
                                appScreenBackgroundDark,
                              ],
                              stops: const [0.0, 0.1, 1.0],
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Popular Section (when no search)
                                HorizontalCardListComponent().visible(
                                  searchCont.searchMovieDetails.isEmpty,
                                ),

                                // Search Results Section
                                if (searchCont.searchCont.text.length > 2)
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Search Header
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Search Results",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: appColorPrimary
                                                    .withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: appColorPrimary
                                                      .withOpacity(0.4),
                                                ),
                                              ),
                                              child: Text(
                                                "${searchCont.searchMovieDetails.length} items",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: appColorPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Search Results
                                      SearchComponent().visible(
                                        searchCont.searchCont.text.length > 2 &&
                                            searchCont.isLoading.isFalse,
                                      ),

                                      20.height.visible(
                                        searchCont.searchCont.text.length > 2,
                                      ),
                                    ],
                                  ),

                                // Popular List (Default)
                                if (searchCont
                                        .defaultPopularList
                                        .data
                                        .isNotEmpty &&
                                    searchCont.searchCont.text.isEmpty)
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 20,
                                      bottom: 30,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: Text(
                                            "Popular Now",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.3,
                                            ),
                                          ),
                                        ),
                                        12.height,
                                        EmptySearchListComponent(
                                          sectionCategoryData:
                                              searchCont.defaultPopularList,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
