import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:media_kit/media_kit.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zatra_tv/locale/language_en.dart';
import 'package:zatra_tv/network/network_utils.dart';
import 'package:zatra_tv/screens/auth/model/app_configuration_res.dart';
import 'package:zatra_tv/screens/auth/model/login_response.dart';
import 'package:zatra_tv/screens/coming_soon/model/coming_soon_response.dart';
import 'package:zatra_tv/screens/home/model/dashboard_res_model.dart';
import 'package:zatra_tv/screens/live_tv/model/live_tv_dashboard_response.dart';
import 'package:zatra_tv/screens/person/model/person_model.dart';
import 'package:zatra_tv/services/in_app_purhcase_service.dart';
import 'package:zatra_tv/utils/local_storage.dart';
import 'package:zatra_tv/video_players/model/video_model.dart';
import 'package:y_player/y_player.dart';

import 'app_theme.dart';
import 'configs.dart';
import 'firebase_options.dart';
import 'locale/app_localizations.dart';
import 'locale/languages.dart';
import 'network/auth_apis.dart';
import 'screens/profile/model/profile_detail_resp.dart';
import 'screens/splash_screen.dart';
import 'utils/app_common.dart';
import 'utils/colors.dart';
import 'utils/common_base.dart';
import 'utils/constants.dart';
import 'utils/local_storage.dart' as local;
import 'utils/push_notification_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log('${FirebaseMsgConst.notificationDataKey} : ${message.data}');
  log('${FirebaseMsgConst.notificationKey} : ${message.notification}');
  log(
    '${FirebaseMsgConst.notificationTitleKey} : ${message.notification!.title}',
  );
  log(
    '${FirebaseMsgConst.notificationBodyKey} : ${message.notification!.body}',
  );
}

Rx<BaseLanguage> locale = LanguageEn().obs;

DashboardDetailResponse? cachedDashboardDetailResponse;

LiveChannelDashboardResponse? cachedLiveTvDashboard;

ProfileDetailResponse? cachedProfileDetails;

InAppPurchaseService inAppPurchaseService = InAppPurchaseService();

// RxLists for cached lists
RxList<VideoPlayerModel> cachedMovieList = RxList<VideoPlayerModel>();
RxList<VideoPlayerModel> cachedTvShowList = RxList<VideoPlayerModel>();
RxList<VideoPlayerModel> cachedVideoList = RxList<VideoPlayerModel>();
RxList<ComingSoonModel> cachedComingSoonList = RxList<ComingSoonModel>();
RxList<VideoPlayerModel> cachedContinueWatchList = RxList<VideoPlayerModel>();
RxList<VideoPlayerModel> cachedWatchList = RxList<VideoPlayerModel>();
RxList<VideoPlayerModel> cachedRentedContentList = RxList<VideoPlayerModel>();
RxList<ChannelModel> cachedChannelList = RxList();
RxList<PersonModel> cachedPersonList = RxList();
RxBool isChild = true.obs;

const platform = MethodChannel('flutter.iqonic.streamitlaravel.com.channel');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize MediaKit
  MediaKit.ensureInitialized();
  YPlayerInitializer.ensureInitialized();
  await _requestPermissions();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
        PushNotificationService().initFirebaseMessaging();
        if (kReleaseMode) {
          FlutterError.onError =
              FirebaseCrashlytics.instance.recordFlutterFatalError;
        }
      })
      .catchError(onError);

  // ADD FCM TOKEN RETRIEVAL HERE
  try {
    // Get the FCM token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      log('FCM Token: $fcmToken');
    } else {
      log('FCM Token is null');
    }

    // Listen for token refreshes
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      log('FCM Token Refreshed: $newToken');
      // Send the new token to your server here
    });
  } catch (e) {
    log('Error getting FCM token: $e');
  }
  await GetStorage.init();
  //
  fontFamilyPrimaryGlobal = GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    fontSize: 16,
  ).fontFamily;
  textPrimarySizeGlobal = 16;
  fontFamilySecondaryGlobal = GoogleFonts.roboto(
    fontWeight: FontWeight.normal,
    color: secondaryTextColor,
    fontSize: 14,
  ).fontFamily;
  textSecondarySizeGlobal = 14;
  fontFamilyBoldGlobal = GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    color: primaryTextColor,
    fontSize: 16,
  ).fontFamily;
  textPrimaryColorGlobal = primaryTextColor;
  textSecondaryColorGlobal = secondaryTextColor;
  //
  defaultBlurRadius = 0;
  defaultRadius = 12;
  defaultSpreadRadius = 0;
  appButtonBackgroundColorGlobal = appColorPrimary;
  defaultAppButtonRadius = defaultRadius;
  defaultAppButtonElevation = 0;
  defaultAppButtonTextColorGlobal = primaryTextColor;
  passwordLengthGlobal = 8;

  selectedLanguageCode(
    local.getValueFromLocal(SELECTED_LANGUAGE_CODE) ?? DEFAULT_LANGUAGE,
  );

  await initialize(
    aLocaleLanguageList: languageList(),
    defaultLanguage: selectedLanguageCode.value,
  );

  BaseLanguage temp = await const AppLocalizations().load(
    Locale(selectedLanguageCode.value),
  );
  locale = temp.obs;
  locale.value = await const AppLocalizations().load(
    Locale(selectedLanguageCode.value),
  );

  if (getStringAsync(SharedPreferenceConst.CONFIGURATION_RESPONSE).isNotEmpty) {
    ConfigurationResponse configData = ConfigurationResponse.fromJson(
      jsonDecode(getStringAsync(SharedPreferenceConst.CONFIGURATION_RESPONSE)),
    );
    appConfigs(configData);
  }

  try {
    final getThemeFromLocal = local.getValueFromLocal(
      SettingsLocalConst.THEME_MODE,
    );
    if (getThemeFromLocal is int) {
      toggleThemeMode(themeId: getThemeFromLocal);
    } else {
      toggleThemeMode(themeId: THEME_MODE_LIGHT);
    }
  } catch (e) {
    log('getThemeFromLocal from cache E: $e');
  }

  isLoggedIn(
    getBoolValueAsync(
          SharedPreferenceConst.IS_LOGGED_IN,
          defaultValue: false,
        ) ||
        getStringAsync(SharedPreferenceConst.USER_DATA).isNotEmpty,
  );

  if (isLoggedIn.value) {
    final userData = getStringAsync(SharedPreferenceConst.USER_DATA);

    if (getStringAsync(SharedPreferenceConst.USER_DATA).isNotEmpty) {
      loginUserData(UserData.fromJson(jsonDecode(userData)));
    } else {
      isLoggedIn(false);
      AuthServiceApis.clearData();
    }
  }
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: appScreenBackgroundDark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: appScreenBackgroundDark,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
  MobileAds.instance.initialize();
  FirebaseMessaging.instance.subscribeToTopic("all");
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  // Notification (Android 13+ only)
  if (Platform.isAndroid) {
    await Permission.notification.request();
  }

  // Camera & Microphone
  await [Permission.camera, Permission.microphone].request();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      supportedLocales: LanguageDataModel.languageLocales(),
      builder: (context, child) {
        return _AppLifecycleObserver(
          child: MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(0.8)),
            child: SafeArea(
              left: false,
              top: false,
              right: false,
              bottom: Platform.isIOS ? false : true,
              child: child!,
            ),
          ),
        );
      },
      localizationsDelegates: const [
        AppLocalizations(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) =>
          Locale(selectedLanguageCode.value),
      fallbackLocale: const Locale(DEFAULT_LANGUAGE),
      locale: Locale(selectedLanguageCode.value),
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      initialBinding: BindingsBuilder(() {
        setStatusBarColor(transparentColor);
      }),
      onGenerateRoute: (settings) {
        if (settings.name.validate().split('/').last.isDigit()) {
          return MaterialPageRoute(
            builder: (context) {
              return SplashScreen(
                deepLink: settings.name.validate(),
                link: true,
              );
            },
          );
        } else {
          return MaterialPageRoute(builder: (_) => SplashScreen());
        }
      },
      home: SplashScreen(),
    );
  }
}

class _AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  const _AppLifecycleObserver({required this.child});

  @override
  State<_AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<_AppLifecycleObserver>
    with WidgetsBindingObserver {
  Timer? _timer;
  int _secondsElapsed = 0;
  DateTime? _appStartTime;
  DateTime? _appPauseTime;
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appStartTime = DateTime.now();
    print('😃😃😃App Open - Application started');

    // Start timer when app opens
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      // Optional: You can print every second if needed
      // print('Timer: $_secondsElapsed seconds');
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  // API call function
  Future<void> _sendTimeToApi(int seconds) async {
    try {
      final headers = buildHeaderTokens();

      final response = await http.post(
        Uri.parse('https://app.zatra.tv/api/track-time'),
        headers: headers,
        body: jsonEncode({
          'seconds': seconds,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        print('😁😁Time tracked successfully: $seconds seconds');
      } else if (response.statusCode == 401) {
        print('😁😁Authentication failed, user might be logged out');
        // আপনার existing token refresh logic ব্যবহার করুন
        await reGenerateToken();
      } else {
        print('😁😁API Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('😁😁Network Error: $e');
    }
  }

  // Retry API call
  Future<void> _retryApiCall(int seconds, {int retryCount = 3}) async {
    for (int i = 0; i < retryCount; i++) {
      await Future.delayed(Duration(seconds: i * 2)); // Exponential backoff
      try {
        final response = await http.post(
          Uri.parse('https://app.zatra.tv/api/track-time'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'seconds': seconds}),
        );

        if (response.statusCode == 200) {
          print('😁😁😁Time tracked on retry $i: $seconds seconds');
          return;
        }
      } catch (e) {
        print('😁😁😁Retry $i failed: $e');
      }
    }
  }

  // Save time locally if API fails
  Future<void> _saveTimeLocally(int seconds) async {
    try {
      final List<dynamic> storedTimes =
          _storage.read('pending_time_tracks') ?? [];
      storedTimes.add({
        'seconds': seconds,
        'timestamp': DateTime.now().toIso8601String(),
      });
      await _storage.write('pending_time_tracks', storedTimes);
      print('😃😃😃Time saved locally for later sync: $seconds seconds');
    } catch (e) {
      print('😃😃😃Error saving time locally: $e');
    }
  }

  // Get device ID
  Future<String> _getDeviceId() async {
    // Get device ID from local storage or generate one
    String? deviceId = _storage.read('device_id');
    if (deviceId == null) {
      deviceId = DateTime.now().millisecondsSinceEpoch.toString();
      await _storage.write('device_id', deviceId);
    }
    return deviceId;
  }

  // Sync pending times
  Future<void> _syncPendingTimes() async {
    try {
      final List<dynamic> pendingTimes =
          _storage.read('pending_time_tracks') ?? [];
      if (pendingTimes.isNotEmpty) {
        for (var timeData in pendingTimes) {
          await _sendTimeToApi(timeData['seconds'] as int);
        }
        await _storage.remove('pending_time_tracks');
        print('Synced ${pendingTimes.length} pending time records');
      }
    } catch (e) {
      print('Error syncing pending times: $e');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        print('😃😃😃App Open - Application is in foreground');
        _appStartTime = DateTime.now();
        _secondsElapsed = 0;
        _startTimer();

        // Sync any pending times when app resumes
        _syncPendingTimes();
        break;

      case AppLifecycleState.inactive:
        print('😃😃😃App Status - Application is inactive');
        _appPauseTime = DateTime.now();
        _stopTimer();

        // Calculate and send session duration
        if (_appStartTime != null && _appPauseTime != null) {
          final totalSeconds = _appPauseTime!
              .difference(_appStartTime!)
              .inSeconds;
          print('😃😃😃App Open to Inactive Duration: $totalSeconds seconds');

          // Send to API if more than 0 seconds
          if (totalSeconds > 0) {
            _sendTimeToApi(totalSeconds);
          }
        }
        break;

      case AppLifecycleState.paused:
        print('😃😃😃App Status - Application is in background');
        break;

      case AppLifecycleState.detached:
        print('😃😃😃App Closed - Application is terminated/closed');
        _stopTimer();

        // Send final time before app closes
        if (_appStartTime != null) {
          final totalSeconds = DateTime.now()
              .difference(_appStartTime!)
              .inSeconds;
          if (totalSeconds > 0) {
            _sendTimeToApi(totalSeconds);
          }
        }
        break;

      case AppLifecycleState.hidden:
        print('😃😃😃App Status - Application is hidden');
        break;
    }
  }

  @override
  void dispose() {
    _stopTimer();
    WidgetsBinding.instance.removeObserver(this);

    // Send time before dispose (as backup)
    if (_appStartTime != null) {
      final totalSeconds = DateTime.now().difference(_appStartTime!).inSeconds;
      if (totalSeconds > 0) {
        _sendTimeToApi(totalSeconds);
      }
    }

    print('😃😃😃App Closed - Application terminated');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
