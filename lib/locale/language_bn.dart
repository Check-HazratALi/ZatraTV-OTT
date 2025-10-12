import 'languages.dart';

class LanguageBn extends BaseLanguage {
  @override
  String get language => 'ভাষা';

  @override
  String get badRequest => '400: খারাপ অনুরোধ';

  @override
  String get forbidden => '403 নিষিদ্ধ';

  @override
  String get pageNotFound => '404: পৃষ্ঠা পাওয়া যায়নি';

  @override
  String get tooManyRequests => '429: অনেক বেশি অনুরোধ';

  @override
  String get internalServerError => '500 অভ্যন্তরীণ সার্ভার ত্রুটি';

  @override
  String get badGateway => '502 খারাপ গেটওয়ে';

  @override
  String get serviceUnavailable => '503: পরিষেবা unavailable';

  @override
  String get gatewayTimeout => '504 গেটওয়ে টাইমআউট';

  @override
  String get gallery => 'গ্যালারি';

  @override
  String get camera => 'ক্যামেরা';

  @override
  String get editProfile => 'প্রোফাইল সম্পাদনা করুন';

  @override
  String get reload => 'পুনরায় লোড করুন';

  @override
  String get pressBackAgainToExitApp =>
      'অ্যাপ থেকে প্রস্থান করতে আবার ব্যাক টিপুন';

  @override
  String get invalidUrl => 'অস্বাভাবিক URL';

  @override
  String get cancel => 'বাতিল করুন';

  @override
  String get delete => 'মুছুন';

  @override
  String get demoUserCannotBeGrantedForThis =>
      'এই ক্রিয়াটির জন্য ডেমো ব্যবহারকারীকে অনুমতি দেওয়া যাবে না';

  @override
  String get somethingWentWrong => 'কিছু ভুল হয়েছে';

  @override
  String get yourInternetIsNotWorking => 'আপনার ইন্টারনেট কাজ করছে না';

  @override
  String get profileUpdatedSuccessfully => 'প্রোফাইল সফলভাবে আপডেট করা হয়েছে';

  @override
  String get wouldYouLikeToSetProfilePhotoAs =>
      'আপনি কি এই ছবিটি আপনার প্রোফাইল ফটো হিসাবে সেট করতে চান?';

  @override
  String get yourConfirmPasswordDoesnT =>
      'আপনার নিশ্চিতকরণ পাসওয়ার্ড পাসওয়ার্ডের সাথে মেলে না!';

  @override
  String get yes => 'হ্যাঁ';

  @override
  String get submit => 'জমা দিন';

  @override
  String get firstName => 'নামের প্রথম অংশ';

  @override
  String get lastName => 'নামের শেষাংশ';

  @override
  String get password => 'পাসওয়ার্ড';

  @override
  String get confirmPassword => 'পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get email => 'ইমেল';

  @override
  String get emailIsARequiredField => 'ইমেল একটি প্রয়োজনীয় ক্ষেত্র';

  @override
  String get pleaseEnterValidEmailAddress => 'একটি বৈধ ইমেল ঠিকানা লিখুন!!';

  @override
  String get signIn => 'সাইন ইন';

  @override
  String get explore => 'অন্বেষণ করুন';

  @override
  String get settings => 'সেটিংস';

  @override
  String get rateNow => 'এখন রেট করুন';

  @override
  String get logout => 'লগ আউট';

  @override
  String get rememberMe => 'আমাকে মনে রাখবেন';

  @override
  String get forgotPassword => 'পাসওয়ার্ড ভুলে গেছেন?';

  @override
  String get signUp => 'নিবন্ধন করুন';

  @override
  String get alreadyHaveAnAccount => 'আপনার কি ইতিমধ্যে একটি অ্যাকাউন্ট আছে?';

  @override
  String get deleteAccount => 'অ্যাকাউন্ট মুছুন';

  @override
  String get notifications => 'বিজ্ঞপ্তি';

  @override
  String get signInFailed => 'সাইন ইন ব্যর্থ হয়েছে';

  @override
  String get logIn => 'লগ ইন';

  @override
  String get stayTunedNoNew => 'থাকুন! কোন নতুন বার্তা নেই।';

  @override
  String get noNewNotificationsAt =>
      'বর্তমানে কোন নতুন বিজ্ঞপ্তি নেই. কোন আপডেট থাকলে আমরা আপনাকে জানাব';

  @override
  String get walkthroughTitle1 =>
      'যেকোনো ডিভাইসে দেখুন: আপনি যেখানেই যান আমাদের কন্টেন্ট উপভোগ করুন!';

  @override
  String get walkthroughDesp1 =>
      'কোন অতিরিক্ত খরচ ছাড়াই সমস্ত ডিভাইসে স্ট্রিম করুন।';

  @override
  String get walkthroughTitle2 =>
      'ডাউনলোড করুন এবং যান: আপনার কন্টেন্ট যেকোনো ডিভাইসে, যেকোনো সময়, যেকোনো জায়গায় অ্যাক্সেস করুন';

  @override
  String get walkthroughDesp2 =>
      'কোনও সময়, কোথাও, কন্টেন্ট ডাউনলোড করুন এবং উপভোগ করুন।';

  @override
  String get walkthroughTitle3 =>
      'কমিটমেন্ট বা ঝামেলা ছাড়াই স্বাধীনতা উপভোগ করুন - আজই আমাদের সাথে যোগ দিন!';

  @override
  String get walkthroughDesp3 =>
      'কোন ঝামেলা ছাড়াই আমাদের সাথে যোগ দিন এবং কোন চুক্তির প্রয়োজন নেই।';

  @override
  String get lblSkip => 'এড়িয়ে যান';

  @override
  String get lblNext => 'পরবর্তী';

  @override
  String get lblGetStarted => 'শুরু করুন';

  @override
  String get optionTitle => 'আপনার পছন্দ অনুযায়ী শৈলী সহ শীর্ষ শো খুঁজুন।';

  @override
  String get optionDesp =>
      'আপনার দেখার পছন্দ অনুযায়ী বিভিন্ন শৈলীতে কিউরেট করা শো দেখুন।';

  @override
  String get welcomeBackToStreamIt => 'Zatra TV এ ফিরে আসায় স্বাগতম!';

  @override
  String get weHaveEagerlyAwaitedYourReturn =>
      'আমরা আপনার ফিরে আসার জন্য অধীর আগ্রহে অপেক্ষা করছি.';

  @override
  String get dontHaveAnAccount => 'কোন অ্যাকাউন্ট নেই? ';

  @override
  String get or => 'বা';

  @override
  String get dontWorryItHappens =>
      'চিন্তা করবেন না! এটা ঘটে। আপনার অ্যাকাউন্টের সাথে যুক্ত ইমেল লিখুন';

  @override
  String get linkSentToYourEmail => 'লিঙ্কটি আপনার ইমেলে পাঠানো হয়েছে!';

  @override
  String get checkYourInboxAndChangePassword =>
      'আপনার ইনবক্স চেক করুন এবং পাসওয়ার্ড পরিবর্তন করুন';

  @override
  String get continues => 'চালিয়ে যান';

  @override
  String get oTPVerification => 'OTP যাচাইকরণ';

  @override
  String get checkYourSmsInboxAndEnterTheCodeYouGet =>
      'আপনার এসএমএস ইনবক্স চেক করুন এবং প্রাপ্ত কোড লিখুন।';

  @override
  String get didntGetTheOTP => 'OTP পাননি?';

  @override
  String get resendOTP => 'OTP পুনরায় পাঠান';

  @override
  String get verify => 'যাচাই করুন';

  @override
  String get clearAll => 'সব সাফ করুন';

  @override
  String get notificationDeleted => 'বিজ্ঞপ্তি মুছে ফেলা হয়েছে';

  @override
  String get doYouWantToRemoveNotification => 'আপনি কি বিজ্ঞপ্তি সরাতে চান';

  @override
  String get doYouWantToClearAllNotification =>
      'আপনি কি সব বিজ্ঞপ্তি সাফ করতে চান?';

  @override
  String get successfully => 'সফলভাবে';

  @override
  String get userCancelled => 'ব্যবহারকারী বাতিল করেছেন';

  @override
  String get appleSigninIsNot => 'Apple সাইন ইন আপনার ডিভাইসে উপলব্ধ নেই';

  @override
  String get searchHere => 'এখানে খুঁজুন';

  @override
  String get noDataFound => 'কোন তথ্য পাওয়া যায়নি';

  @override
  String get subscribe => 'সাবস্ক্রাইব';

  @override
  String get subscribeToWatch => 'দেখতে সাবস্ক্রাইব করুন';

  @override
  String get playNow => 'এখন খেলুন';

  @override
  String get continueWatching => 'দেখা চালিয়ে যান ';

  @override
  String get shareYourThoughtsWithUs =>
      'আমাদের সাথে আপনার চিন্তাভাবনা শেয়ার করুন!';

  @override
  String get weValueYourOpinion =>
      'আমরা আপনার মতামতকে গুরুত্ব দিই! আজই আপনার প্রতিক্রিয়া আমাদের সাথে শেয়ার করুন।';

  @override
  String get genres => 'ধরন';

  @override
  String get trailer => 'ট্রেলার';

  @override
  String get ua18 => 'U/A 18';

  @override
  String get watchNow => 'এখন দেখুন';

  @override
  String get cast => 'কাস্ট';

  @override
  String get directors => 'পরিচালক';

  @override
  String get reviews => 'রিভিউ';

  @override
  String get viewAll => 'সব দেখ';

  @override
  String get rating => 'রেটিং';

  @override
  String get justNow => 'এক্ষুনি ';

  @override
  String get daysAgo => 'দিন আগে';

  @override
  String get yesterday => 'গতকাল';

  @override
  String get ago => 'আগে';

  @override
  String get min => 'মিনিট';

  @override
  String get hr => 'ঘন্টা';

  @override
  String get s => 'সে';

  @override
  String get moreLikeThis => 'এরকম আরও';

  @override
  String get shareYourThoughtsOnYourFavoriteMovie =>
      'আপনার প্রিয় সিনেমা সম্পর্কে আপনার চিন্তাভাবনা শেয়ার করুন';

  @override
  String get rateThisMovie => 'এই সিনেমাটি রেট করুন';

  @override
  String get rateThisTvShow => 'এই টিভি শোটি রেট করুন';

  @override
  String get yourReview => 'আপনার রিভিউ';

  @override
  String get edit => 'সম্পাদনা করুন';

  @override
  String get close => 'বন্ধ';

  @override
  String get oppsLooksLikeYouReview =>
      'ওহ! মনে হচ্ছে আপনি এখনও কোনো রিভিউ যোগ করেননি।';

  @override
  String get retry => 'পুনরায় চেষ্টা করুন';

  @override
  String get selectDownloadQuality => 'ডাউনলোডের গুণমান নির্বাচন করুন';

  @override
  String get onlyOnWiFi => 'শুধুমাত্র Wi-Fi তে';

  @override
  String get download => 'ডাউনলোড';

  @override
  String get moviesOf => 'এর সিনেমা ';

  @override
  String get season => 'সিজন';

  @override
  String get episode => 'এপিসোড ';

  @override
  String get watchlist => 'ওয়াচলিস্ট';

  @override
  String get searchMoviesShowsAndMore => 'সিনেমা, শো এবং আরও অনেক কিছু খুঁজুন';

  @override
  String get trendingMovies => 'ট্রেন্ডিং মুভি ';

  @override
  String get comingSoon => 'শীঘ্রই আসছে';

  @override
  String get remindMe => 'মনে করিয়ে দাও';

  @override
  String get remind => 'মনে করিয়ে দিন';

  @override
  String get readLess => 'কম পড়ুন';

  @override
  String get readMore => '...আরও পড়ুন';

  @override
  String get liveTv => 'লাইভ টিভি';

  @override
  String get live => 'লাইভ';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get expiringOn => 'এ মেয়াদ শেষ হচ্ছে';

  @override
  String get updrade => 'আপগ্রেড';

  @override
  String get subscribeToEnjoyMore => 'আরও উপভোগ করতে সাবস্ক্রাইব করুন';

  @override
  String get daysFreeTrail => 'আজই বিশেষ সুবিধাগুলি আনলক করুন';

  @override
  String get privacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get helpSupport => 'সাহায্য ও সহায়তা';

  @override
  String get appLanguage => 'অ্যাপ ভাষা';

  @override
  String get yourDownloads => 'আপনার ডাউনলোড';

  @override
  String get subscriptionPlanDeviceConnected =>
      'সাবস্ক্রিপশন প্ল্যান, ডিভাইস সংযুক্ত';

  @override
  String get accountSettings => 'অ্যাকাউন্ট সেটিংস';

  @override
  String get version => 'সংস্করণ';

  @override
  String get registeredMobileNumber => 'নিবন্ধিত মোবাইল নম্বর';

  @override
  String get otherDevices => 'অন্যান্য ডিভাইস';

  @override
  String get yourDevice => 'আপনার ডিভাইস';

  @override
  String get lastUsed => 'সর্বশেষ ব্যবহৃত';

  @override
  String get proceed => 'এগিয়ে যান';

  @override
  String get allYourDataWill => 'আপনার সমস্ত ডেটা স্থায়ীভাবে মুছে ফেলা হবে';

  @override
  String get deleteAccountPermanently => 'অ্যাকাউন্ট স্থায়ীভাবে মুছুন?';

  @override
  String get mobileNumber => 'মোবাইল নম্বর';

  @override
  String get savechanges => 'পরিবর্তনগুলি সংরক্ষণ করুন';

  @override
  String get loginToStreamit => 'Zatra TV এ লগ ইন করুন';

  @override
  String get startWatchingFromWhereYouLeftOff =>
      'যেখানে থেমেছিলেন সেখান থেকে দেখা শুরু করুন';

  @override
  String get troubleLoggingIn => 'লগইন করতে সমস্যা?';

  @override
  String get getHelp => 'সাহায্য নিন';

  @override
  String get yourWatchlistIsEmpty => 'আপনার ওয়াচলিস্ট খালি';

  @override
  String get contentAddedToYourWatchlist =>
      'আপনার ওয়াচলিস্টে যোগ করা কন্টেন্ট এখানে দেখানো হবে';

  @override
  String get add => 'যোগ করুন';

  @override
  String get subscribeNowAndDiveInto =>
      'এখনই সাবস্ক্রাইব করুন এবং অবিরাম স্ট্রিমিং উপভোগ করুন';

  @override
  String get pay => 'পে';

  @override
  String get next => 'পরবর্তী';

  @override
  String get subscrption => 'সাবস্ক্রিপশন';

  @override
  String get validUntil => 'পর্যন্ত বৈধ ';

  @override
  String get choosePaymentMethod => 'পেমেন্ট পদ্ধতি নির্বাচন করুন';

  @override
  String get secureCheckoutInSeconds => 'সেকেন্ডে 100% সুরক্ষিত চেকআউট';

  @override
  String get proceedPayment => 'পেমেন্ট এগিয়ে নিন';

  @override
  String get actors => 'অভিনেতা';

  @override
  String get movies => 'সিনেমা';

  @override
  String get contentRestrictedAccess => '18+ কন্টেন্ট সীমিত অ্যাক্সেস';

  @override
  String get areYou18Above => 'আপনি কি 18+ এর উপরে?';

  @override
  String get displayAClearProminentWarning =>
      'কন্টেন্ট অ্যাক্সেস করার আগে একটি স্পষ্ট এবং বিশিষ্ট সতর্কতা প্রদর্শন করুন, যা নির্দেশ করে যে এটি পরিপক্ক দর্শকদের জন্য।';

  @override
  String get all => 'সব';

  @override
  String get tVShows => 'টিভি শো';

  @override
  String get videos => 'ভিডিও';

  @override
  String get newlyAdded => 'নতুন যোগ করা';

  @override
  String get free => 'বিনামূল্যে';

  @override
  String get phnRequiredText => 'মোবাইল নম্বর প্রয়োজন';

  @override
  String get inputMustBeNumberOrDigit => 'ইনপুট অবশ্যই সংখ্যা বা অঙ্ক হতে হবে';

  @override
  String get dateOfBirth => 'জন্ম তারিখ';

  @override
  String get whatYourMobileNo => 'আপনার মোবাইল নম্বর কি';

  @override
  String get withAValidMobileNumberYouCanConnectWithStreamit =>
      'একটি বৈধ মোবাইল নম্বর দিয়ে আপনি Zatra TV এর সাথে সংযোগ করতে পারেন';

  @override
  String get otpSentToYourSMS => 'আপনার এসএমএসে OTP পাঠানো হয়েছে!';

  @override
  String get checkYourSmsInboxAndVerifyYoourMobile =>
      'আপনার এসএমএস ইনবক্স চেক করুন এবং আপনার মোবাইল নম্বর যাচাই করুন';

  @override
  String get pleaseTryAgainAfterSomeTime =>
      'কিছু সময় পরে আবার চেষ্টা করুন. আপনি অনেকবার যাচাইকরণের অনুরোধ ব্যবহার করেছেন!';

  @override
  String get pleaseEnterAValidCode => 'একটি বৈধ OTP লিখুন';

  @override
  String get pleaseCheckYourMobileInternetConnection =>
      'আপনার মোবাইল ইন্টারনেট সংযোগ পরীক্ষা করুন';

  @override
  String get error => 'ত্রুটি';

  String get sorryCouldnTFindYourSearch =>
      'দুঃখিত, আপনার অনুসন্ধান খুঁজে পাওয়া যায়নি!';

  @override
  String get trySomethingNew => 'কিছু নতুন চেষ্টা করুন.';

  @override
  String get genresNotAvailable => 'ধরন উপলব্ধ নেই!';

  @override
  String get downloadSuccessfully => 'সফলভাবে ডাউনলোড করুন';

  @override
  String get popularMovies => 'জনপ্রিয় সিনেমা';

  @override
  String get confirm => 'নিশ্চিত করুন';

  @override
  String get doYouConfirmThisPlan =>
      'আপনি কি এই সাবস্ক্রিপশন প্ল্যান নিশ্চিত করেন ';

  @override
  String get transactionFailed => 'লেনদেন ব্যর্থ';

  @override
  String get transactionCancelled => 'লেনদেন বাতিল';

  @override
  String get no => 'না';

  @override
  String get lblChangeCountry => 'দেশ পরিবর্তন করুন';

  @override
  String get logOutAll => 'সব লগ আউট করুন';

  @override
  String get taxIncluded => 'ট্যাক্স অন্তর্ভুক্ত';

  @override
  String get bookNow => 'এখন বুক করুন';

  @override
  String get firstNameIsRequiredField => 'নামের প্রথম অংশ প্রয়োজন';

  @override
  String get lastNameIsRequiredField => 'নামের শেষাংশ প্রয়োজন';

  @override
  String get passwordIsRequiredField => 'পাসওয়ার্ড প্রয়োজন';

  @override
  String get confirmPasswordIsRequiredField =>
      'নিশ্চিত করুন পাসওয়ার্ড প্রয়োজন';

  @override
  String get pleaseEnterConfirmPassword => 'নিশ্চিতকরণ পাসওয়ার্ড লিখুন';

  @override
  String get home => 'হোম';

  @override
  String get search => 'খুঁজুন';

  @override
  String get mobileNumberIsRequiredField =>
      'মোবাইল নম্বর একটি প্রয়োজনীয় ক্ষেত্র';

  @override
  String get youHaveAlreadyDownloadedThisMovie =>
      'আপনি এই সিনেমাটি ইতিমধ্যেই ডাউনলোড করেছেন';

  @override
  String get imdb => 'IMDb';

  @override
  String get mb => 'MB';

  @override
  String get stripePay => 'Stripe Pay';

  @override
  String get razorPay => 'Razor Pay';

  @override
  String get payStackPay => 'PayStack Pay';

  @override
  String get paypalPay => 'PayPal Pay';

  @override
  String get flutterWavePay => 'FlutterWave Pay';

  @override
  String get contextNotFound => 'প্রসঙ্গ পাওয়া যায়নি!!!!';

  @override
  String get verificationFailed => 'যাচাইকরণ ব্যর্থ হয়েছে';

  @override
  String get english => 'ইংরেজি';

  @override
  String get hour => 'ঘন্টা';

  @override
  String get minute => 'মিনিট';

  @override
  String get sec => 'সেকেন্ড';

  @override
  String get videoNotFound => 'ভিডিও পাওয়া যায়নি!!';

  @override
  String get auto => 'অটো';

  @override
  String get recommended => 'প্রস্তাবিত';

  @override
  String get medium => 'মধ্যম';

  @override
  String get high => 'উচ্চ';

  @override
  String get low => 'নিম্ন';

  @override
  String get helpSetting => 'সাহায্য এবং সেটিংস';

  @override
  String get pleaseConfirmContent =>
      'দয়া করে কন্টেন্ট সীমিত অ্যাক্সেস নিশ্চিত করুন';

  @override
  String get toWatch => 'দেখতে';

  @override
  String get plan => 'প্ল্যান';

  @override
  String get toThe => 'প্রতি';

  @override
  String get noDeviceAvailable => 'কোন ডিভাইস উপলব্ধ নেই';

  @override
  String get noItemsToContinueWatching =>
      'দেখা চালিয়ে যাওয়ার জন্য কোন আইটেম নেই';

  @override
  String get noItemsAddedToTheWatchlist =>
      'ওয়াচলিস্টে কোন আইটেম যোগ করা হয়নি';

  @override
  String get ok => 'ঠিক আছে';

  @override
  String get removeFromContinueWatch =>
      'আপনি কি দেখা চালিয়ে যাওয়া থেকে সরাতে চান?';

  @override
  String get addedToWatchList => 'ওয়াচলিস্টে সফলভাবে যোগ করা হয়েছে';

  @override
  String get removedFromWatchList => 'ওয়াচলিস্ট থেকে সফলভাবে সরানো হয়েছে';

  @override
  String get removeSelectedFromWatchList =>
      'আপনি কি আপনার ওয়াচলিস্ট থেকে নির্বাচিত কন্টেন্ট সরাতে চান?';

  @override
  String get removedFromContinueWatch =>
      'সফলভাবে দেখা চালিয়ে যাওয়া থেকে সরানো হয়েছে';

  @override
  String get pleaseEnterAValidMobileNo => 'একটি বৈধ মোবাইল নম্বর লিখুন';

  @override
  String get pleaseAddYourReview => 'আপনার রেটিং যোগ করুন';

  @override
  String get thisMovieIsCurrentlUnavailableToWatch =>
      'এই সিনেমাটি বর্তমানে দেখার জন্য উপলব্ধ নয়';

  @override
  String get thisVideoIsCurrentlUnavailableToWatch =>
      'এই ভিডিওটি বর্তমানে দেখার জন্য উপলব্ধ নয়';

  @override
  String get subscriptionHistory => 'সাবস্ক্রিপশন ইতিহাস';

  @override
  String get type => 'টাইপ';

  @override
  String get amount => 'পরিমাণ';

  @override
  String get cancelPlan => 'প্ল্যান বাতিল করুন';

  @override
  String get device => 'ডিভাইস';

  @override
  String get clear => 'সাফ';

  @override
  String get doYouWantToLogoutFrom => 'আপনি কি থেকে লগআউট করতে চান';

  @override
  String get sAlphabet => 'এস';

  @override
  String get eAlphabet => 'ই';

  @override
  String get viewLess => 'কম দেখুন';

  @override
  String get removeSelectedFromDownloads =>
      'আপনি কি এটিকে আপনার ডাউনলোড থেকে সরাতে চান?';

  @override
  String get noPaymentMethodsFound => 'কোন পেমেন্ট পদ্ধতি পাওয়া যায়নি';

  @override
  String get save => 'সংরক্ষণ';

  @override
  String get completeProfile => 'আপনার প্রোফাইল সম্পূর্ণ করুন';

  @override
  String get completeProfileSubtitle =>
      'শুরু করতে আমাদের আপনার সম্পর্কে আরও বলুন';

  @override
  String get getVerificationCode => 'যাচাইকরণ কোড পান';

  @override
  String get contentRating => 'কন্টেন্ট রেটিং';

  @override
  String get profiles => 'প্রোফাইল';

  @override
  String get addProfile => 'প্রোফাইল যোগ করুন';

  @override
  String get clearSearchHistoryConfirmation =>
      'আপনি কি আপনার অনুসন্ধান ইতিহাস সাফ করতে চান?';

  @override
  String get clearSearchHistorySubtitle =>
      'এই ক্রিয়াটি পূর্বাবস্থায় ফেরানো যাবে না এবং পূর্ববর্তী সমস্ত অনুসন্ধান স্থায়ীভাবে মুছে ফেলা হবে।';

  @override
  String get searchingForDevice => 'ডিভাইস অনুসন্ধান করা হচ্ছে';

  @override
  String get screenCast => 'স্ক্রীন কাস্ট';

  @override
  String get connectTo => 'সংযোগ করুন';

  @override
  String get disconnectFrom => 'থেকে সংযোগ বিচ্ছিন্ন করুন';

  @override
  String get signInWithGoogle => 'Google দিয়ে সাইন ইন করুন';

  @override
  String get signInWithApple => 'Apple দিয়ে সাইন ইন করুন';

  @override
  String get whoIsWatching => 'কে দেখছে?';

  @override
  String get doYouWantTo => 'আপনি কি অনুসন্ধান ইতিহাস সাফ করতে চান?';

  @override
  String get mobile => 'মোবাইল:  ';

  @override
  String get tablet => 'ট্যাবলেট: ';

  @override
  String get laptop => 'ল্যাপটপ:  ';

  @override
  String get supported => 'সমর্থিত';

  @override
  String get notSupported => 'সমর্থিত নয়';

  @override
  String get freeMovies => 'বিনামূল্যের সিনেমা';

  @override
  String get top10 => 'শীর্ষ 10';

  @override
  String get latestMovies => 'সর্বশেষ সিনেমা';

  @override
  String get topChannels => 'শীর্ষ চ্যানেল';

  @override
  String get popularTvShows => 'জনপ্রিয় টিভি শো';

  @override
  String get popularVideos => 'জনপ্রিয় ভিডিও';

  @override
  String get popularLanguages => 'জনপ্রিয় ভাষা';

  @override
  String get trending => 'ট্রেন্ডিং';

  @override
  String get trendingInYourCountry => 'আপনার দেশে ট্রেন্ডিং';

  @override
  String get favoriteGenres => 'প্রিয় ধরণ';

  @override
  String get basedOnYourPreviousWatch =>
      'আপনার পূর্ববর্তী দেখার উপর ভিত্তি করে';

  @override
  String get mostLiked => 'সবচেয়ে পছন্দনীয়';

  @override
  String get mostViewed => 'সবচেয়ে বেশি দেখা';

  @override
  String get yourFavoritePersonalities => 'আপনার প্রিয় ব্যক্তিত্ব';

  @override
  String get name => 'নাম';

  @override
  String get nameCannotBeEmpty => 'নাম খালি হতে পারে না';

  @override
  String get update => 'আপডেট';

  @override
  String get remove => 'অপসারণ';

  @override
  String get recentSearch => 'সাম্প্রতিক অনুসন্ধান';

  @override
  String get noRecentSearches => 'কোন সাম্প্রতিক অনুসন্ধান নেই';

  @override
  String get chooseImageSource => 'ছবির উৎস নির্বাচন করুন';

  @override
  String get noInternetAvailable => 'কোন ইন্টারনেট উপলব্ধ নেই';

  @override
  String get goToYourDownloads => 'আপনার ডাউনলোডে যান';

  @override
  String get bySigningYouAgreeTo => 'স্বাক্ষর করার মাধ্যমে, আপনি সম্মত হন';

  @override
  String get lowQuality => 'নিম্ন মান';

  @override
  String get mediumQuality => 'মধ্যম মান';

  @override
  String get highQuality => 'উচ্চ মান';

  @override
  String get veryHighQuality => 'অতি উচ্চ মান';

  @override
  String get ultraQuality => 'অতি মান';

  @override
  String get termsConditions => 'শর্তাবলী';

  @override
  String get ofAll => 'সমস্ত';

  @override
  String get servicesAnd => 'সেবা এবং ';

  @override
  String get newProfileAddedSuccessfully =>
      'নতুন প্রোফাইল সফলভাবে যোগ করা হয়েছে';

  @override
  String get doYouWantToDeleteYourReview => 'আপনি কি আপনার রিভিউ মুছতে চান?';

  @override
  String get noSearchDataFound => 'কোন অনুসন্ধান ডেটা পাওয়া যায়নি';

  @override
  String get searchHistory => 'অনুসন্ধান ইতিহাস';

  @override
  String get youHaveBeenLoggedOutOfYourAccountOn =>
      'আপনাকে আপনার অ্যাকাউন্ট থেকে লগ আউট করা হয়েছে';

  @override
  String get faqs => 'প্রায়শই জিজ্ঞাসিত প্রশ্ন';

  @override
  String get termsOfUse => 'ব্যবহারের শর্তাবলী';

  @override
  String get dataDeletionRequest => 'ডেটা মুছে ফেলার অনুরোধ';

  @override
  String get aboutUs => 'আমাদের সম্পর্কে';

  @override
  String get total => 'মোট';

  @override
  String get refundAndCancellationPolicy => 'ফেরত এবং বাতিলকরণ নীতি';

  @override
  String get percentage => 'শতাংশ';

  @override
  String get fixed => 'স্থির';

  @override
  String get android => 'Android';

  @override
  String get ios => 'iOS';

  @override
  String get bangla => 'বাংলা';

  @override
  String get noFAQsfound => 'কোন FAQ পাওয়া যায়নি';

  @override
  String get tax => 'ট্যাক্স';

  @override
  String get downloadHasBeenStarted => 'ডাউনলোড শুরু হয়েছে';

  @override
  String get yourDeviceIsNot =>
      'আপনার ডিভাইস বর্তমান প্ল্যানের সাথে সমর্থিত নয়';

  @override
  String get pleaseUpgradeToContinue =>
      'সেবা উপভোগ করা চালিয়ে যেতে দয়া করে আপগ্রেড করুন';

  @override
  String get cancelled => 'বাতিল';

  @override
  String get expired => 'মেয়াদোত্তীর্ণ';

  @override
  String get active => 'সক্রিয়';

  @override
  String get connectToWIFI => 'দয়া করে Wi-Fi এর সাথে সংযোগ করুন';

  @override
  String get logoutAllConfirmation =>
      'আপনি কি অন্য সমস্ত ডিভাইস লগ আউট করতে চান?';

  @override
  String get share => 'শেয়ার করুন';

  @override
  String get like => 'লাইক';

  @override
  String get pip => 'PIP';

  @override
  String get videoCast => 'কাস্ট';

  @override
  String get castingNotSupported => 'বর্তমান প্ল্যানে কাস্টিং সমর্থিত নয়';

  @override
  String get left => "বাকি";

  @override
  String get loginWithOtp => 'OTP দিয়ে লগইন করুন';

  @override
  String get loginWithEmail => 'ইমেল দিয়ে লগইন করুন';

  @override
  String get createYourAccount => 'আপনার অ্যাকাউন্ট তৈরি করুন';

  @override
  String get changePassword => 'পাসওয়ার্ড পরিবর্তন করুন';

  @override
  String get yourNewPasswordMust =>
      'আপনার নতুন পাসওয়ার্ড আপনার আগের পাসওয়ার্ড থেকে আলাদা হতে হবে';

  @override
  String get yourOldPasswordDoesnT => 'আপনার পুরানো পাসওয়ার্ড সঠিক নয়!';

  @override
  String get yourNewPasswordDoesnT =>
      'আপনার নতুন পাসওয়ার্ড নিশ্চিতকরণ পাসওয়ার্ডের সাথে মেলে না!';

  @override
  String get oldAndNewPassword => 'পুরানো এবং নতুন পাসওয়ার্ড একই।';

  @override
  String get yourPasswordHasBeen => 'আপনার পাসওয়ার্ড সফলভাবে রিসেট করা হয়েছে';

  @override
  String get youCanNowLog =>
      'এখন আপনি আপনার নতুন পাসওয়ার্ড দিয়ে আপনার নতুন অ্যাকাউন্টে লগ ইন করতে পারেন';

  @override
  String get done => 'সম্পন্ন';

  @override
  String get oldPassword => 'পুরানো পাসওয়ার্ড';

  @override
  String get newPassword => 'নতুন পাসওয়ার্ড';

  @override
  String get confirmNewPassword => 'নতুন পাসওয়ার্ড নিশ্চিত করুন';

  @override
  String get birthdayIsRequired => 'জন্মদিন প্রয়োজন';

  @override
  String get childrenSProfile => 'শিশুদের প্রোফাইল';

  @override
  String get madeForKidsUnder12 => '12 বছরের কম বয়সী শিশুদের জন্য তৈরি';

  @override
  String get otpVerifiedFailed => 'OTP যাচাইকরণ ব্যর্থ হয়েছে';

  @override
  String get otpVerifiedSuccessfully => 'OTP সফলভাবে যাচাই করা হয়েছে';

  @override
  String get otpSentSuccessfully => 'OTP সফলভাবে পাঠানো হয়েছে';

  @override
  String get weHaveSentYouOTPOnYourRegisterEmailAddress =>
      'আমরা আপনাকে আপনার নিবন্ধিত ইমেল ঠিকানায় OTP পাঠিয়েছি';

  @override
  String get otpVerification => 'OTP যাচাইকরণ';

  @override
  String get enterPIN => 'পিন লিখুন';

  @override
  String get enterYourNewParentalPinForYourKids =>
      'আপনার বাচ্চাদের জন্য আপনার নতুন প্যারেন্টাল পিন লিখুন';

  @override
  String get confirmPIN => 'পিন নিশ্চিত করুন';

  @override
  String get setPIN => 'পিন সেট করুন';

  @override
  String get changePIN => 'পিন পরিবর্তন করুন';

  @override
  String get parentalControl => 'প্যারেন্টাল কন্ট্রোল';

  @override
  String get invalidPIN => 'অবৈধ পিন';

  @override
  String get kids => 'বাচ্চারা';

  @override
  String get enter4DigitParentalControlPIN =>
      '4 অঙ্কের প্যারেন্টাল কন্ট্রোল পিন লিখুন';

  @override
  String get parentalLock => 'প্যারেন্টাল লক';

  @override
  String get profileDeletedSuccessfully => 'প্রোফাইল সফলভাবে মুছে ফেলা হয়েছে';

  @override
  String get pinNotMatched => 'পিন মেলে নি';

  @override
  String get pleaseEnterNewPIN => 'দয়া করে নতুন পিন লিখুন';

  @override
  String get pleaseEnterConfirmPin => 'দয়া করে নিশ্চিতকরণ পিন লিখুন';

  @override
  String get codeWithColon => 'কোড লিখুন:';

  @override
  String get useThisCodeToGet => 'পেতে এই কোডটি ব্যবহার করুন ';

  @override
  String get off => ' বন্ধ';

  @override
  String get expiryDate => 'মেয়াদ শেষ হওয়ার তারিখ: ';

  @override
  String get apply => 'প্রয়োগ করুন';

  @override
  String get coupons => 'কুপন';

  @override
  String get enterCouponCode => 'কুপন কোড লিখুন';

  @override
  String get check => 'চেক করুন';

  @override
  String get allCoupons => 'সমস্ত কুপন';

  @override
  String get oopsWeCouldnTFind => 'ওহ! আমরা কোনো মিলেছে কুপন কোড খুঁজে পাইনি';

  @override
  String get doYouWantToRemoveCoupon => 'আপনি কি এই কুপনটি সরাতে চান?';

  @override
  String get noSubscriptionHistoryFound =>
      'কোনো সাবস্ক্রিপশন ইতিহাস পাওয়া যায়নি';

  @override
  String get couponDiscount => 'কুপন ছাড় ';

  @override
  String get linkTv => 'লিংক টিভি';

  @override
  String get youHaveBeenLoggedOutSuccessfully => 'আপনি সফলভাবে লগআউট হয়েছেন';

  @override
  String get rented => 'ভাড়া করা';

  @override
  String get rent => 'ভাড়া';

  @override
  String get rentFor => 'ভাড়া জন্য';

  @override
  String rentedesc(int availableFor, String duration) =>
      'ভাড়া নেওয়ার পরে, দেখানো শুরু করার জন্য আপনার কাছে $availableFor দিন সময় থাকবে। স্ট্রিমিং শুরু করার পরে, শেষ করার জন্য আপনার কাছে $duration দিন সময় থাকবে।';

  @override
  String youCanWatchThis(int duration) =>
      'আপনি এই কন্টেন্টটি $duration দিনের সময়সীমার মধ্যে একাধিকবার দেখতে পারেন।';

  @override
  String get thisIsANonRefundable => 'এটি একটি অ-ফেরতযোগ্য লেনদেন।';

  @override
  String get thisContentIsOnly =>
      'এই কন্টেন্টটি শুধুমাত্র ভাড়ায় উপলব্ধ এবং প্রিমিয়াম সাবস্ক্রিপশনের অংশ নয়।';

  @override
  String get youCanPlayYour =>
      'আপনি আপনার কন্টেন্ট সমর্থিত ডিভাইসে চালাতে পারেন।';

  @override
  String get validity => 'বৈধতা';

  @override
  String get days => 'দিন';

  @override
  String get watchTime => 'দেখার সময়';

  @override
  String get hours => 'ঘন্টা';

  @override
  String get byRentingYouAgreeToOur =>
      'ভাড়া নেওয়ার মাধ্যমে আপনি আমাদের শর্তাবলীতে সম্মত হন';

  @override
  String get pleaseAgreeToThe =>
      'অগ্রসর হওয়ার আগে দয়া করে ব্যবহারের শর্তাবলীতে সম্মত হন।';

  @override
  String get successfullyRentedMoviesOn => 'সফলভাবে ভাড়া করা সিনেমা';

  @override
  String enjoyUntilDays(int days) => '$days দিন পর্যন্ত উপভোগ করুন';

  @override
  String get beginWatching => 'দেখা শুরু করুন';

  @override
  String doYouConfirmThis(String movieName) =>
      'আপনি কি এই ভাড়ার পরিকল্পনাটি নিশ্চিত করেন যে আপনি $movieName ভাড়া নিতে চান';

  @override
  String get unlockedVideo => 'আনলক ভিডিও';

  @override
  String get info => 'তথ্য';

  @override
  String get payPerView => 'পে পার ভিউ';

  @override
  String skipIn(int seconds) => 'এড়িয়ে যান $seconds';

  @override
  String get newPinSuccessfullySaved => 'নতুন পিন সফলভাবে সংরক্ষিত হয়েছে';

  @override
  String get successfullyUpdated => 'সফলভাবে আপডেট করা হয়েছে';

  @override
  String get defaultLabel => 'ডিফল্ট';

  @override
  String get quality => 'গুণমান';

  @override
  String get subtitle => 'সাবটাইটেল';

  @override
  String get skip => 'স্কিপ';

  @override
  String get nextEpisode => 'পরবর্তী এপিসোড';

  @override
  String get rentDetails => 'ভাড়ার বিবরণ';

  @override
  String get tvLinkedSuccessfully => 'টিভি সফলভাবে লিংক করা হয়েছে!';

  @override
  String get pleaseSelectPaymentMethod => 'একটি পেমেন্ট পদ্ধতি নির্বাচন করুন।';

  @override
  String get cameraPermissionDenied =>
      'ক্যামেরা অনুমতি অস্বীকার করা হয়েছে। দয়া করে সেটিংসে এটি সক্ষম করুন।';

  @override
  String get advertisement => 'বিজ্ঞাপন';

  @override
  String get castConnectInfo =>
      'নিশ্চিত করুন যে আপনার Chromecast ডিভাইস চালু আছে এবং একই Wi-Fi নেটওয়ার্কের সাথে সংযুক্ত।';

  @override
  String get connect => 'সংযোগ করুন';

  @override
  String get disconnect => 'সংযোগ বিচ্ছিন্ন করুন';

  @override
  String get playOnTV => 'টিভিতে চালান';

  @override
  String get readyToCastToYourDevice =>
      'আপনার ডিভাইসে কাস্ট করার জন্য প্রস্তুত';

  @override
  String get castSupportInfo =>
      'কাস্টিং শুধুমাত্র URL, HLS, বা লোকাল টাইপের ভিডিওর জন্য সমর্থিত। অন্যান্য ফরম্যাট কাস্টিংয়ের জন্য সমর্থিত নয়।';

  @override
  String get sorryCouldnFindYourSearch => throw UnimplementedError();
}
