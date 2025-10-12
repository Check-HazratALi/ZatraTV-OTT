import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tihd/screens/movie_details/movie_details_controller.dart';
import 'package:tihd/screens/payment/model/payment_model.dart';
import 'package:tihd/screens/tv_show/tv_show_controller.dart';
import 'package:tihd/screens/video/video_details_controller.dart';
import 'package:tihd/utils/app_common.dart';
import 'package:tihd/utils/constants.dart';
import 'package:tihd/video_players/model/video_model.dart';

import '../../network/auth_apis.dart';
import '../../network/core_api.dart';
import '../../utils/common_base.dart';
import '../coupon/coupon_list_controller.dart';
import '../dashboard/dashboard_screen.dart';
import '../subscription/model/subscription_plan_model.dart';
import 'payment_gateways/flutter_wave_service.dart';

class PaymentController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isPaymentLoading = false.obs;
  RxString paymentOption = PaymentMethods.PAYMENT_METHOD_STRIPE.obs;
  RxList<PaymentSetting> originalPaymentList = RxList();
  Rx<Future<RxList<PaymentSetting>>> getPaymentFuture =
      Future(() => RxList<PaymentSetting>()).obs;
  Rx<SubscriptionPlanModel> selectPlan = SubscriptionPlanModel().obs;
  RxDouble price = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble rentPrice = 0.0.obs;
  RxBool isRent = false.obs;
  Rx<DateTime> currentDate = DateTime.now().obs;
  Rx<PaymentSetting> selectPayment = PaymentSetting().obs;
  Rx<VideoPlayerModel> videoPlayerModel = VideoPlayerModel().obs;

  // Payment Class
  FlutterWaveService flutterWaveServices = FlutterWaveService();

  Rx<Future<RxBool>> getPaymentInitialized = Future(() => false.obs).obs;

  RxBool launchDashboard = true.obs;

  // Coupon
  CouponListController couponListClassCont = CouponListController();

  @override
  void onInit() {
    if (Get.arguments[0] is SubscriptionPlanModel) {
      selectPlan(Get.arguments[0]);
      price(Get.arguments[1]);
      discount(Get.arguments[2]);
      launchDashboard(Get.arguments[3]);
    }
    if (Get.arguments[0] is VideoPlayerModel) {
      rentPrice(Get.arguments[0]);
      discount(Get.arguments[1]);
      videoPlayerModel(Get.arguments[2]);
      isRent(true);
    }
    allApisCalls();
    super.onInit();
  }

  Future<void> allApisCalls() async {
    await getAppConfigurations();

    /// Fetch Coupon List
    fetchCouponList();
  }

  Future<void> fetchCouponList() async {
    if (isRent.value) return;
    isLoading(true);
    await couponListClassCont
        .getCouponList(
      selectedPlanId: selectPlan.value.planId.toString(),
      perPageItem: 2,
    )
        .then((value) {
      isLoading(false);
    }).onError((error, stackTrace) {
      isLoading(false);
      log('Coupon List Error: ${error.toString()}');
    });
  }

  Future<void> getAppConfigurations() async {
    isPaymentLoading(true);
    await AuthServiceApis.getAppConfigurations(forceSync: true)
        .then((value) async {
      getPaymentInitialized(Future(() async => getPayment()))
          .whenComplete(() => isLoading(false));
    }).onError((error, stackTrace) {
      toast(error.toString());
    }).whenComplete(() {
      isPaymentLoading(false);
    });
  }

  Future<void> initInAppPurchase() async {}

  ///Get Payment List
  Future<RxBool> getPayment({bool showLoader = true}) async {
    isPaymentLoading(showLoader);
    originalPaymentList.clear();
    if (appConfigs.value.stripePay.stripePublickey.isNotEmpty) {
      originalPaymentList.add(
        PaymentSetting(
          id: 0,
          title: "SslCommerz",
          type: PaymentMethods.PAYMENT_METHOD_STRIPE,
          liveValue: LiveValue(
              stripePublickey: appConfigs.value.stripePay.stripePublickey,
              stripeKey: appConfigs.value.stripePay.stripeSecretkey),
        ),
      );
    }
    isPaymentLoading(false);

    return true.obs;
  }

//saveSubscriptionDetails

  void saveSubscriptionDetails(
      {required String transactionId, required String paymentType}) {
    isLoading(true);
    Map<String, dynamic> request = {
      "plan_id": selectPlan.value.planId,
      "user_id": loginUserData.value.id,
      "identifier": selectPlan.value.name.validate(),
      "payment_status": PaymentStatus.PAID,
      "payment_type": paymentType,
      "transaction_id": transactionId.validate(),
      'device_id': yourDevice.value.deviceId,
    };

    if (couponListClassCont.appliedCouponData.value.code.isNotEmpty) {
      request.putIfAbsent(
          'coupon_id', () => couponListClassCont.appliedCouponData.value.id);
    }

    if (paymentType == PaymentMethods.PAYMENT_METHOD_IN_APP_PURCHASE) {
      request.putIfAbsent(
        'active_in_app_purchase_identifier',
        () => isIOS
            ? selectPlan.value.appleInAppPurchaseIdentifier
            : selectPlan.value.googleInAppPurchaseIdentifier,
      );
    }
    CoreServiceApis.saveSubscriptionDetails(
      request: request,
    ).then((value) async {
      if (launchDashboard.value) {
        Get.offAll(() =>
            DashboardScreen(dashboardController: getDashboardController()));
      } else {
        Get.back();
        Get.back();
      }
      getDashboardController().getActiveVastAds();
      getDashboardController().getActiveCustomAds().then((value) {
        getDashboardController().adPlayerController.getCustomAds();
      });

      setValue(SharedPreferenceConst.USER_DATA, loginUserData.toJson());
      // successSnackBar(value.message.toString());
      currentSubscription(value.data);
      if (currentSubscription.value.level > -1 &&
          currentSubscription.value.planType.isNotEmpty &&
          currentSubscription.value.planType
              .any((element) => element.slug == SubscriptionTitle.videoCast)) {
        isCastingSupported(currentSubscription.value.planType
            .firstWhere(
                (element) => element.slug == SubscriptionTitle.videoCast)
            .limitationValue
            .getBoolInt());
      } else {
        isCastingSupported(false);
      }
      currentSubscription.value.activePlanInAppPurchaseIdentifier = isIOS
          ? currentSubscription.value.appleInAppPurchaseIdentifier
          : currentSubscription.value.googleInAppPurchaseIdentifier;
      setValue(
          SharedPreferenceConst.USER_SUBSCRIPTION_DATA, value.data.toJson());
      setValue(SharedPreferenceConst.USER_DATA, loginUserData.toJson());

      successSnackBar(value.message.toString());
    }).catchError((e) {
      isLoading(false);
      errorSnackBar(error: e);
    }).whenComplete(() {
      isLoading(false);
    });
  }

  Future<void> saveRentDetails(
      {required String transactionId,
      required String paymentType,
      required VoidCallback onSuccess}) async {
    if (isLoading.value) return;
    isLoading(true);
    String typeValue = videoPlayerModel.value.type.validate();
    if (typeValue.isEmpty) {
      typeValue = "episode";
    }
    Map<String, dynamic> request = {
      "user_id": loginUserData.value.id,
      "price": videoPlayerModel.value.discountedPrice.validate(),
      "discount": videoPlayerModel.value.discount.validate(),
      "payment_status": PaymentStatus.PAID,
      "payment_type": paymentType,
      "transaction_id": transactionId.validate(),
      "purchase_type": videoPlayerModel.value.purchaseType.validate(),
      "access_duration": videoPlayerModel.value.accessDuration.validate(),
      "available_for": videoPlayerModel.value.availableFor.validate(),
      "movie_id": videoPlayerModel.value.id.validate(),
      "type": typeValue,
    };

    await CoreServiceApis.saveRentDetails(request: request).then((value) async {
      Get.back();
      videoPlayerModel.refresh();
      if (videoPlayerModel.value.type == VideoType.movie) {
        final movieDetCont = Get.find<MovieDetailsController>();
        movieDetCont.getMovieDetail();
      } else if (videoPlayerModel.value.type == VideoType.episode ||
          typeValue == VideoType.episode) {
        final tvShowCont = Get.find<TvShowController>();
        tvShowCont.refresh();
        tvShowCont.getEpisodeDetail(
            episodeId: videoPlayerModel.value.episodeId);
      } else if (videoPlayerModel.value.type == VideoType.video) {
        final videoCont = Get.find<VideoDetailsController>();
        videoCont.getMovieDetail();
      }
      onSuccess.call();
    }).catchError((e) {
      errorSnackBar(error: e);
    }).whenComplete(() async {
      isLoading(false);
    });
  }
}
