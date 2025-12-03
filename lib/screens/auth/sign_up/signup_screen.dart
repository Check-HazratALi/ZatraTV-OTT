import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:zatra_tv/generated/assets.dart';
import 'package:zatra_tv/main.dart';
import 'package:zatra_tv/utils/colors.dart';
import 'package:zatra_tv/utils/extension/date_time_extention.dart';
import 'package:zatra_tv/utils/extension/string_extention.dart';

import '../../../components/cached_image_widget.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SingleChildScrollView(
            child: Form(
              key: signUpController.signUpFormKey,
              child: Column(
                children: [
                  60.height,
                  // Header Section
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 24,
                    ),
                    child: Column(
                      children: [
                        const CachedImageWidget(
                          url: Assets.assetsAppLogo,
                          height: 80,
                        ),
                        24.height,
                        Text(
                          locale.value.createYourAccount,
                          style: boldTextStyle(size: 24, color: white),
                        ),
                        8.height,
                        Text(
                          locale.value.completeProfileSubtitle,
                          style: secondaryTextStyle(
                            color: white.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // Form Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Phone Number
                        _buildPhoneField(context),
                        16.height,

                        // First Name
                        _buildFirstNameField(context),
                        16.height,

                        // Last Name
                        _buildLastNameField(context),
                        16.height,

                        // Date of Birth
                        _buildDateOfBirthField(context),
                        16.height,

                        // Gender Selection
                        _buildGenderSelection(),
                        16.height,

                        // Email
                        _buildEmailField(context),
                        16.height,

                        // Password
                        _buildPasswordField(context),
                        16.height,

                        // Confirm Password
                        _buildConfirmPasswordField(context),
                        32.height,

                        // Sign Up Button
                        _buildSignUpButton(context),
                        24.height,

                        // Already have account
                        _buildLoginLink(),
                        40.height,
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

  Widget _buildPhoneField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.mobileNumber,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                child: Text('+88', style: primaryTextStyle(color: white)),
              ),
              Expanded(
                child: TextFormField(
                  controller: signUpController.mobileCont,
                  focusNode: signUpController.mobileFocus,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: primaryTextStyle(color: white),
                  decoration: InputDecoration(
                    hintText: '01XXXXXXXXX',
                    hintStyle: secondaryTextStyle(
                      color: white.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    errorStyle: TextStyle(color: Colors.red[300]),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return locale.value.phnRequiredText;
                    }
                    return null;
                  },
                  onChanged: (value) => signUpController.onBtnEnable(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFirstNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.firstName,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextFormField(
            controller: signUpController.firstNameCont,
            focusNode: signUpController.firstNameFocus,
            textInputAction: TextInputAction.next,
            style: primaryTextStyle(color: white),
            decoration: InputDecoration(
              hintText: locale.value.firstName,
              hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorStyle: TextStyle(color: Colors.red[300]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.firstNameIsRequiredField;
              }
              return null;
            },
            onChanged: (value) => signUpController.onBtnEnable(),
          ),
        ),
      ],
    );
  }

  Widget _buildLastNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.lastName,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextFormField(
            controller: signUpController.lastNameCont,
            focusNode: signUpController.lastNameFocus,
            textInputAction: TextInputAction.next,
            style: primaryTextStyle(color: white),
            decoration: InputDecoration(
              hintText: locale.value.lastName,
              hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorStyle: TextStyle(color: Colors.red[300]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.lastNameIsRequiredField;
              }
              return null;
            },
            onChanged: (value) => signUpController.onBtnEnable(),
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.dateOfBirth,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextFormField(
            controller: signUpController.dobCont,
            focusNode: signUpController.dobFocus,
            readOnly: true,
            style: primaryTextStyle(color: white, size: 14),
            decoration: InputDecoration(
              hintText: 'YYYY-MM-DD',
              hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              suffixIcon: Icon(
                Icons.calendar_today,
                color: white.withOpacity(0.7),
                size: 20,
              ),
              errorStyle: TextStyle(color: Colors.red[300]),
            ),
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: signUpController.dobCont.text.isNotEmpty
                    ? DateTime.parse(signUpController.dobCont.text)
                    : null,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                confirmText: locale.value.ok,
                cancelText: locale.value.cancel,
                helpText: locale.value.dateOfBirth,
                locale: Locale(
                  selectedLanguageDataModel?.languageCode ??
                      getStringAsync(SELECTED_LANGUAGE_CODE),
                ),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.dark(
                        brightness: Brightness.dark,
                        surface: cardColor,
                        surfaceTint: cardColor,
                        primary: appColorPrimary,
                        onPrimary: primaryTextColor,
                      ),
                      hintColor: secondaryTextColor,
                      inputDecorationTheme: const InputDecorationTheme(
                        isDense: true,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 2,
                          bottom: 2,
                        ),
                        hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                        fillColor: appColorPrimary,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (selectedDate != null) {
                signUpController.dobCont.text = selectedDate
                    .formatDateYYYYmmdd();
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.birthdayIsRequired;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender", style: primaryTextStyle(color: white, size: 14)),
        8.height,
        Obx(
          () => Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => signUpController.setGender(Gender.male),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          signUpController.selectedGender.value == Gender.male
                          ? appColorPrimary.withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            signUpController.selectedGender.value == Gender.male
                            ? appColorPrimary
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.male,
                          color:
                              signUpController.selectedGender.value ==
                                  Gender.male
                              ? appColorPrimary
                              : white.withOpacity(0.7),
                          size: 16,
                        ),
                        8.width,
                        Text(
                          "Male",
                          style: primaryTextStyle(
                            color:
                                signUpController.selectedGender.value ==
                                    Gender.male
                                ? appColorPrimary
                                : white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: InkWell(
                  onTap: () => signUpController.setGender(Gender.female),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          signUpController.selectedGender.value == Gender.female
                          ? appColorPrimary.withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            signUpController.selectedGender.value ==
                                Gender.female
                            ? appColorPrimary
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.female,
                          color:
                              signUpController.selectedGender.value ==
                                  Gender.female
                              ? appColorPrimary
                              : white.withOpacity(0.7),
                          size: 16,
                        ),
                        8.width,
                        Text(
                          "Female",
                          style: primaryTextStyle(
                            color:
                                signUpController.selectedGender.value ==
                                    Gender.female
                                ? appColorPrimary
                                : white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: InkWell(
                  onTap: () => signUpController.setGender(Gender.other),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          signUpController.selectedGender.value == Gender.other
                          ? appColorPrimary.withOpacity(0.2)
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            signUpController.selectedGender.value ==
                                Gender.other
                            ? appColorPrimary
                            : Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.transgender,
                          color:
                              signUpController.selectedGender.value ==
                                  Gender.other
                              ? appColorPrimary
                              : white.withOpacity(0.7),
                          size: 16,
                        ),
                        8.width,
                        Text(
                          "Other",
                          style: primaryTextStyle(
                            color:
                                signUpController.selectedGender.value ==
                                    Gender.other
                                ? appColorPrimary
                                : white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.email,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: TextFormField(
            controller: signUpController.emailCont,
            focusNode: signUpController.emailFocus,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: primaryTextStyle(color: white),
            decoration: InputDecoration(
              hintText: 'example@email.com',
              hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              errorStyle: TextStyle(color: Colors.red[300]),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.emailIsARequiredField;
              } else if (!value.isValidEmail()) {
                return locale.value.pleaseEnterValidEmailAddress;
              }
              return null;
            },
            onChanged: (value) => signUpController.onBtnEnable(),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.password,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: TextFormField(
              controller: signUpController.passwordCont,
              focusNode: signUpController.passwordFocus,
              obscureText: !signUpController.isPasswordVisible.value,
              textInputAction: TextInputAction.next,
              style: primaryTextStyle(color: white),
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpController.isPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: white.withOpacity(0.7),
                    size: 20,
                  ),
                  onPressed: () {
                    signUpController.togglePasswordVisibility();
                  },
                ),
                errorStyle: TextStyle(color: Colors.red[300]),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return locale.value.passwordIsRequiredField;
                }
                return null;
              },
              onChanged: (value) => signUpController.onBtnEnable(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          locale.value.confirmPassword,
          style: primaryTextStyle(color: white, size: 14),
        ),
        8.height,
        Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: TextFormField(
              controller: signUpController.confPasswordCont,
              focusNode: signUpController.confPasswordFocus,
              obscureText: !signUpController.isConfirmPasswordVisible.value,
              textInputAction: TextInputAction.done,
              style: primaryTextStyle(color: white),
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: secondaryTextStyle(color: white.withOpacity(0.5)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    signUpController.isConfirmPasswordVisible.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: white.withOpacity(0.7),
                    size: 20,
                  ),
                  onPressed: () {
                    signUpController.toggleConfirmPasswordVisibility();
                  },
                ),
                errorStyle: TextStyle(color: Colors.red[300]),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return locale.value.passwordIsRequiredField;
                }
                return signUpController.passwordCont.text == value
                    ? null
                    : locale.value.yourConfirmPasswordDoesnT;
              },
              onChanged: (value) => signUpController.onBtnEnable(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: signUpController.isBtnEnable.value
              ? () {
                  hideKeyboard(context);
                  signUpController.saveForm();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: appColorPrimary,
            disabledBackgroundColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: signUpController.isLoading.value
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Text(
                  locale.value.signUp,
                  style: boldTextStyle(color: white, size: 16),
                ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          locale.value.alreadyHaveAnAccount,
          style: secondaryTextStyle(color: white.withOpacity(0.7)),
        ),
        4.width,
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Text(
            locale.value.signIn,
            style: boldTextStyle(color: appColorPrimary, size: 14),
          ),
        ),
      ],
    );
  }
}
