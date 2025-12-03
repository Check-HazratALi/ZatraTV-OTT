// ignore_for_file: depend_on_referenced_packages

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/network/auth_apis.dart';
import 'package:zatra_tv/screens/auth/sign_in/sign_in_controller.dart';
import 'package:zatra_tv/screens/profile/watching_profile/watching_profile_screen.dart';
import 'package:zatra_tv/utils/extension/string_extention.dart';

import '../../../configs.dart';
import '../../../utils/app_common.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../sign_in/sign_in_screen.dart';

enum Gender { male, female, other }

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBtnEnable = false.obs;
  RxBool isPhoneAuth = false.obs;
  RxString countryCode = "+880".obs;
  final GlobalKey<FormState> signUpFormKey = GlobalKey();

  var selectedGender = Gender.male.obs;

  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  // Methods to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  RxBool agree = false.obs;
  RxBool isAcceptedTc = false.obs;

  TextEditingController emailCont = TextEditingController();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController confPasswordCont = TextEditingController();
  TextEditingController userTypeCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController dobCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confPasswordFocus = FocusNode();
  FocusNode userTypeFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode dobFocus = FocusNode();

  Rx<Country> selectedCountry = defaultCountry.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments[0] is bool) {
        isPhoneAuth(true);
      }
      if (Get.arguments[1] is RxString) {
        mobileCont.text = Get.arguments[1].value;
        passwordCont.text = Get.arguments[1].value;
        confPasswordCont.text = Get.arguments[1].value;
      }
      if (Get.arguments[2] is RxString) {
        countryCode.value = Get.arguments[2].value;

        mobileCont.text = mobileCont.text.prefixText(value: countryCode.value);
      }
    }
    super.onInit();
  }

  void setGender(Gender gender) {
    selectedGender.value = gender;
  }

  Future<void> saveForm() async {
    if (isLoading.isTrue) return;

    isLoading(true);
    hideKeyBoardWithoutContext();

    if (firstNameCont.text.trim().isEmpty) {
      toast("First name is required");
      isLoading(false);
      return;
    }

    if (lastNameCont.text.trim().isEmpty) {
      toast("Last name is required");
      isLoading(false);
      return;
    }

    if (emailCont.text.trim().isEmpty) {
      toast("Email is required");
      isLoading(false);
      return;
    }

    if (!emailCont.text.trim().isValidEmail()) {
      toast("Please enter a valid email address");
      isLoading(false);
      return;
    }

    if (passwordCont.text.trim().isEmpty) {
      toast("Password is required");
      isLoading(false);
      return;
    }

    if (confPasswordCont.text.trim().isEmpty) {
      toast("Confirm password is required");
      isLoading(false);
      return;
    }

    if (passwordCont.text.trim() != confPasswordCont.text.trim()) {
      toast("Passwords do not match");
      isLoading(false);
      return;
    }

    if (mobileCont.text.trim().isEmpty) {
      toast("Mobile number is required");
      isLoading(false);
      return;
    }

    if (dobCont.text.trim().isEmpty) {
      toast("Date of birth is required");
      isLoading(false);
      return;
    }

    Map<String, dynamic> req;

    if (isPhoneAuth.isTrue) {
      req = {
        "email": emailCont.text.trim(),
        "first_name": firstNameCont.text.trim(),
        "last_name": lastNameCont.text.trim(),
        "password": mobileCont.text.trim(),
        "mobile": mobileCont.text.trim(),
        "gender": selectedGender.value.name,
        UserKeys.username: mobileCont.text.trim(),
        UserKeys.loginType: LoginTypeConst.LOGIN_TYPE_OTP,
      };
    } else {
      req = {
        "email": emailCont.text.trim(),
        "first_name": firstNameCont.text.trim(),
        "last_name": lastNameCont.text.trim(),
        "password": passwordCont.text.trim(),
        "mobile": "${countryCode.value}${mobileCont.text.trim()}",
        "gender": selectedGender.value.name,
        "date_of_birth": dobCont.text.trim(),
        "confirm_password": confPasswordCont.text.trim(),
      };
    }

    log('Sending request to API: $req');

    try {
      await AuthServiceApis.createUser(request: req)
          .then((value) async {
            log('API Response: $value');

            if (isPhoneAuth.isTrue) {
              final SignInController verificationController = Get.put(
                SignInController(),
              );
              verificationController.mobileNo(
                mobileCont.text.trim().splitAfter(countryCode.value),
              );
              verificationController.phoneSignIn();
            } else {
              try {
                Map<String, dynamic> loginReq = {
                  'email': emailCont.text.trim(),
                  'password': passwordCont.text.trim(),
                  'device_id': yourDevice.value.deviceId,
                  'device_name': yourDevice.value.deviceName,
                  'platform': yourDevice.value.platform,
                };

                log('Login request: $loginReq');

                await AuthServiceApis.loginUser(request: loginReq)
                    .then((value) async {
                      handleLoginResponse();
                    })
                    .whenComplete(() {
                      isLoading(false);
                    })
                    .catchError((e) {
                      isLoading(false);
                      Get.to(() => SignInScreen());
                    });
              } catch (e) {
                log('Login Error: $e');
                toast(e.toString(), print: true);
              }
              Get.back();
              toast(value, print: true);
            }
          })
          .catchError((e) {
            log('Create User Error: $e');
            toast(e.toString(), print: true);
          });
    } finally {
      isLoading(false);
    }
  }

  void onBtnEnable() {
    if (mobileCont.text.isNotEmpty &&
        firstNameCont.text.isNotEmpty &&
        lastNameCont.text.isNotEmpty &&
        emailCont.text.isNotEmpty &&
        passwordCont.text.isNotEmpty &&
        confPasswordCont.text.isNotEmpty) {
      isBtnEnable(true);
    } else {
      isBtnEnable(false);
    }
  }

  void onClear() {
    firstNameCont.clear();
    lastNameCont.clear();
    emailCont.clear();
    passwordCont.clear();
    confPasswordCont.clear();
    isBtnEnable(false);
  }

  @override
  void onClose() {
    firstNameCont.clear();
    lastNameCont.clear();
    emailCont.clear();
    passwordCont.clear();
    confPasswordCont.clear();
    mobileCont.clear();
    dobCont.clear();

    super.onClose();
  }

  void handleLoginResponse({String? password, bool isSocialLogin = false}) {
    try {
      Get.offAll(() => WatchingProfileScreen());
      isLoading(false);
    } catch (e) {
      log("Error  ==> $e");
    }
  }
}
