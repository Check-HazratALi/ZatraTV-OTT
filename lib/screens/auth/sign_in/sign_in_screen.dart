import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/components/app_scaffold.dart';
import 'package:zatra_tv/configs.dart';
import 'package:zatra_tv/generated/assets.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/screens/auth/model/about_page_res.dart';
import 'package:zatra_tv/utils/app_common.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/utils/constants.dart';
import 'package:zatra_tv/utils/extension/string_extention.dart';
import '../../../components/cached_image_widget.dart';
import '../sign_in/sign_in_controller.dart';
import '../sign_up/signup_screen.dart';
import 'component/social_auth.dart';

class SignInScreen extends StatelessWidget {
  final bool showBackButton;

  SignInScreen({super.key, this.showBackButton = true});

  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with subtle gradient
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

          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: MediaQuery.of(context).padding.bottom + 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Button
                  if (showBackButton)
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () => Get.back(),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                  40.height,

                  // App Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: appColorPrimary.withOpacity(0.3),
                          blurRadius: 50,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CachedImageWidget(
                      url: Assets.assetsAppLogo,
                      height: 100,
                      width: 100,
                    ).center(),
                  ),

                  24.height,

                  // Welcome Text
                  Text(
                    locale.value.welcomeBackToStreamIt,
                    style: boldTextStyle(size: 28, color: white).copyWith(
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  8.height,
                  Text(
                    locale.value.weHaveEagerlyAwaitedYourReturn,
                    textAlign: TextAlign.center,
                    style: secondaryTextStyle(
                      size: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ).paddingSymmetric(horizontal: 24),

                  40.height,

                  // Login Form
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: signInController.signInformKey,
                      child: Obx(() {
                        if (signInController.isNormalLogin.value) {
                          return _buildEmailLoginForm(context);
                        } else {
                          return _buildPhoneLoginForm(context);
                        }
                      }),
                    ),
                  ),

                  24.height,

                  // OR Divider
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            locale.value.or,
                            style: secondaryTextStyle(
                              color: Colors.white.withOpacity(0.5),
                              size: 14,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.white.withOpacity(0.2),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  24.height,

                  // Toggle Login Method
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Obx(() {
                      return InkWell(
                        onTap: () {
                          signInController.isNormalLogin(
                            !signInController.isNormalLogin.value,
                          );
                        },
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                ),
                                child: Icon(
                                  signInController.isNormalLogin.value
                                      ? Icons.phone_rounded
                                      : Icons.email_rounded,
                                  color: white,
                                  size: 20,
                                ),
                              ),
                              12.width,
                              Text(
                                signInController.isNormalLogin.value
                                    ? locale.value.loginWithOtp
                                    : locale.value.loginWithEmail,
                                style: boldTextStyle(size: 16, color: white),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),

                  // Social Login
                  if (appConfigs.value.isEnableSocialLogin) ...[
                    24.height,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: SocialAuthComponent(),
                    ),
                  ],

                  32.height,

                  // Sign Up Link
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: locale.value.dontHaveAnAccount,
                          style: secondaryTextStyle(
                            size: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        TextSpan(
                          text: " ${locale.value.signUp}",
                          style: boldTextStyle(
                            size: 14,
                            color: appColorPrimary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => SignUpScreen());
                            },
                        ),
                      ],
                    ),
                  ),

                  32.height,

                  // Terms and Privacy
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            final AboutDataModel aboutDataModel = appPageList
                                .firstWhere(
                                  (element) =>
                                      element.slug ==
                                      AppPages.termsAndCondition,
                                );
                            if (aboutDataModel.url.validate().isNotEmpty)
                              launchUrlCustomURL(aboutDataModel.url.validate());
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${locale.value.bySigningYouAgreeTo} $APP_NAME ',
                                  style: secondaryTextStyle(
                                    size: 12,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                                TextSpan(
                                  text: locale.value.termsConditions,
                                  style: secondaryTextStyle(
                                    size: 12,
                                    color: appColorPrimary,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${locale.value.ofAll}',
                                  style: secondaryTextStyle(
                                    size: 12,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        8.height,
                        GestureDetector(
                          onTap: () {
                            final AboutDataModel aboutDataModel = appPageList
                                .firstWhere(
                                  (element) =>
                                      element.slug == AppPages.privacyPolicy,
                                );
                            if (aboutDataModel.url.validate().isNotEmpty)
                              launchUrlCustomURL(aboutDataModel.url.validate());
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${locale.value.servicesAnd} ',
                                  style: secondaryTextStyle(
                                    size: 12,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                                TextSpan(
                                  text: locale.value.privacyPolicy,
                                  style: secondaryTextStyle(
                                    size: 12,
                                    color: appColorPrimary,
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailLoginForm(BuildContext context) {
    return Column(
      children: [
        // Email Field
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: AppTextField(
            textStyle: primaryTextStyle(color: white),
            controller: signInController.emailCont,
            focus: signInController.emailFocus,
            nextFocus: signInController.passwordFocus,
            textFieldType: TextFieldType.EMAIL_ENHANCED,
            cursorColor: white,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.emailIsARequiredField;
              } else if (!value.isValidEmail()) {
                return locale.value.pleaseEnterValidEmailAddress;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: locale.value.email,
              hintStyle: secondaryTextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              border: InputBorder.none,
              prefixIcon: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  Icons.email_rounded,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (value) {
              signInController.getBtnEnable();
            },
          ),
        ),

        16.height,

        // Password Field
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: AppTextField(
            textStyle: primaryTextStyle(color: white),
            controller: signInController.passwordCont,
            focus: signInController.passwordFocus,
            obscureText: true,
            textFieldType: TextFieldType.PASSWORD,
            cursorColor: white,
            isValidationRequired: true,
            errorThisFieldRequired: locale.value.passwordIsRequiredField,
            decoration: InputDecoration(
              hintText: locale.value.password,
              hintStyle: secondaryTextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              border: InputBorder.none,
              prefixIcon: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  Icons.lock_rounded,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  // Toggle password visibility
                },
                child: Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.visibility_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 20,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            suffixPasswordVisibleWidget: Icon(
              Icons.visibility_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ).paddingAll(16),
            suffixPasswordInvisibleWidget: Icon(
              Icons.visibility_off_rounded,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ).paddingAll(16),
            onChanged: (value) {
              signInController.getBtnEnable();
            },
          ),
        ),

        16.height,

        // Remember Me & Forgot Password
        Row(
          children: [
            // Remember Me
            InkWell(
              onTap: () {
                signInController.isRememberMe.value =
                    !signInController.isRememberMe.value;
              },
              borderRadius: BorderRadius.circular(6),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: signInController.isRememberMe.value
                      ? appColorPrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: signInController.isRememberMe.value
                        ? appColorPrimary
                        : Colors.white.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: signInController.isRememberMe.value
                    ? Icon(Icons.check_rounded, color: white, size: 14)
                    : null,
              ),
            ),
            12.width,
            Text(
              locale.value.rememberMe,
              style: secondaryTextStyle(
                size: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ],
        ),

        24.height,

        // Sign In Button
        Obx(() {
          return InkWell(
            onTap: () {
              if (signInController.signInformKey.currentState!.validate()) {
                signInController.saveForm(isNormalLogin: true);
              }
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appColorPrimary, appColorPrimary.withOpacity(0.8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appColorPrimary.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  locale.value.signIn,
                  style: boldTextStyle(size: 16, color: white),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPhoneLoginForm(BuildContext context) {
    return Column(
      children: [
        // Phone Number Field
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: AppTextField(
            textStyle: primaryTextStyle(color: white),
            controller: signInController.phoneCont,
            textFieldType: TextFieldType.PHONE,
            cursorColor: white,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (mobileCont) {
              if (mobileCont == null || mobileCont.isEmpty) {
                return "Phone number is required";
              }
              if (!RegExp(r'^(01[3-9]\d{8})$').hasMatch(mobileCont)) {
                return "Please enter a valid Bangladeshi number";
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "01X XXX XXXX",
              hintStyle: secondaryTextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
              border: InputBorder.none,
              prefixIcon: Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(left: 16, right: 12),
                child: Icon(
                  Icons.phone_rounded,
                  color: Colors.white.withOpacity(0.7),
                  size: 20,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16),
            ),
            onChanged: (value) {
              signInController.getBtnEnable();
            },
            onFieldSubmitted: (value) {
              if (signInController.signInformKey.currentState!.validate()) {
                hideKeyboard(context);
                signInController.onLoginPressed();
              }
            },
          ),
        ),

        24.height,

        // Get Verification Code Button
        Obx(() {
          return InkWell(
            onTap: () {
              if (signInController.signInformKey.currentState!.validate()) {
                hideKeyboard(Get.context!);
                signInController.onLoginPressed();
              }
            },
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [appColorPrimary, appColorPrimary.withOpacity(0.8)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: appColorPrimary.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.phone_rounded, color: white, size: 20),
                    12.width,
                    Text(
                      locale.value.getVerificationCode,
                      style: boldTextStyle(size: 16, color: white),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),

        16.height,

        // Info Text
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_rounded, color: appColorPrimary, size: 18),
              12.width,
              Expanded(
                child: Text(
                  "We'll send a verification code to your phone number",
                  style: secondaryTextStyle(
                    size: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
