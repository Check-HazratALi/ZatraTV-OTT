import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zatra_tv/utils/constants.dart';
import 'package:zatra_tv/utils/extension/date_time_extention.dart';
import 'package:zatra_tv/utils/extension/string_extention.dart';
import 'package:zatra_tv/generated/assets.dart';
import '../../../../main.dart';
import '../../../../utils/app_common.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../edit_profile_controller.dart';
import 'package:nb_utils/nb_utils.dart';

class EditFormFieldComponent extends StatelessWidget {
  EditFormFieldComponent({super.key});

  final EditProfileController profileCont = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: profileCont.editProfileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          24.height,
          // First Name Field - Modern Design
          _buildModernTextField(
            context: context,
            controller: profileCont.firstNameCont,
            focusNode: profileCont.firstNameFocus,
            nextFocus: profileCont.lastNameFocus,
            labelText: locale.value.firstName,
            iconPath: Assets.iconsIcDefaultUser,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.firstNameIsRequiredField;
              }
              return null;
            },
            onChanged: (value) => profileCont.onBtnEnable(),
          ),
          16.height,

          // Last Name Field
          _buildModernTextField(
            context: context,
            controller: profileCont.lastNameCont,
            focusNode: profileCont.lastNameFocus,
            nextFocus: profileCont.emailFocus,
            labelText: locale.value.lastName,
            iconPath: Assets.iconsIcDefaultUser,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.lastNameIsRequiredField;
              }
              return null;
            },
            onChanged: (value) => profileCont.onBtnEnable(),
          ),
          16.height,

          // Date of Birth Field
          _buildModernTextField(
            context: context,
            controller: profileCont.dobCont,
            focusNode: profileCont.dobFocus,
            labelText: locale.value.dateOfBirth,
            iconPath: Assets.iconsIcBirthdate,
            readOnly: true,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: profileCont.dobCont.text.isNotEmpty
                    ? DateTime.parse(profileCont.dobCont.text)
                    : DateTime.now().subtract(const Duration(days: 365 * 18)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                confirmText: locale.value.ok,
                cancelText: locale.value.cancel,
                helpText: "Select Date of Birth",
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
                profileCont.dobCont.text = selectedDate.formatDateYYYYmmdd();
              }
            },
          ),
          20.height,

          // Gender Selection - Modern Card Design
          _buildGenderSection(context),
          20.height,

          // Email Field
          _buildModernTextField(
            context: context,
            controller: profileCont.emailCont,
            focusNode: profileCont.emailFocus,
            nextFocus: profileCont.mobileNoFocus,
            labelText: locale.value.email,
            iconPath: Assets.iconsIcEmail,
            enabled:
                loginUserData.value.loginType == LoginTypeConst.LOGIN_TYPE_OTP,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              } else if (!value.isValidEmail()) {
                return locale.value.pleaseEnterValidEmailAddress;
              }
              return null;
            },
            onChanged: (value) => profileCont.onBtnEnable(),
          ),
          16.height,

          // Mobile Number Field
          _buildModernTextField(
            context: context,
            controller: profileCont.mobileNoCont,
            focusNode: profileCont.mobileNoFocus,
            labelText: locale.value.mobileNumber,
            iconPath: Assets.iconsIcPhone,
            textInputType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return locale.value.mobileNumberIsRequiredField;
              }
              return null;
            },
            onChanged: (value) => profileCont.onBtnEnable(),
          ),
          40.height,

          // Save Button - Modern Design
          Obx(
            () => Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: profileCont.isBtnEnable.isTrue
                    ? LinearGradient(
                        colors: [
                          appColorPrimary,
                          appColorPrimary.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: !profileCont.isBtnEnable.isTrue ? cardDarkColor : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: profileCont.isBtnEnable.isTrue
                    ? [
                        BoxShadow(
                          color: appColorPrimary.withOpacity(0.3),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: profileCont.isBtnEnable.isTrue
                      ? () {
                          if (profileCont.editProfileFormKey.currentState!
                              .validate()) {
                            profileCont.updateProfile();
                          }
                        }
                      : null,
                  child: Center(
                    child: Text(
                      locale.value.savechanges,
                      style: boldTextStyle(
                        size: 16,
                        color: profileCont.isBtnEnable.isTrue
                            ? Colors.white
                            : Colors.white54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          20.height,
        ],
      ),
    );
  }

  // Modern Text Field Widget
  Widget _buildModernTextField({
    required BuildContext context,
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
    required String labelText,
    required String iconPath,
    bool readOnly = false,
    bool enabled = true,
    String? Function(String?)? validator,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    TextInputType textInputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: secondaryTextStyle(size: 14, color: Colors.white70),
        ),
        8.height,
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: focusNode.hasFocus ? appColorPrimary : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: focusNode.hasFocus
                ? [
                    BoxShadow(
                      color: appColorPrimary.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    iconPath,
                    color: focusNode.hasFocus
                        ? appColorPrimary
                        : Colors.white70,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              12.width,
              Expanded(
                child: TextFormField(
                  controller: controller,
                  focusNode: focusNode,
                  readOnly: readOnly,
                  enabled: enabled,
                  validator: validator,
                  onTap: onTap,
                  onChanged: onChanged,
                  keyboardType: textInputType,
                  inputFormatters: inputFormatters,
                  style: primaryTextStyle(size: 16, color: Colors.white),
                  cursorColor: appColorPrimary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: labelText,
                    hintStyle: secondaryTextStyle(color: Colors.white54),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  onFieldSubmitted: (_) {
                    if (nextFocus != null) {
                      nextFocus.requestFocus();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Modern Gender Selection Widget
  Widget _buildGenderSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: secondaryTextStyle(size: 14, color: Colors.white70),
        ),
        8.height,
        Obx(
          () => Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildGenderOption(
                  context: context,
                  gender: Gender.male,
                  label: "Male",
                  icon: Icons.male,
                  isSelected: profileCont.selectedGender.value == Gender.male,
                  onTap: () => profileCont.setGender(Gender.male),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.1),
                ),
                _buildGenderOption(
                  context: context,
                  gender: Gender.female,
                  label: "Female",
                  icon: Icons.female,
                  isSelected: profileCont.selectedGender.value == Gender.female,
                  onTap: () => profileCont.setGender(Gender.female),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.white.withOpacity(0.1),
                ),
                _buildGenderOption(
                  context: context,
                  gender: Gender.other,
                  label: "Other",
                  icon: Icons.transgender,
                  isSelected: profileCont.selectedGender.value == Gender.other,
                  onTap: () => profileCont.setGender(Gender.other),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required BuildContext context,
    required Gender gender,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? appColorPrimary.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? appColorPrimary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? appColorPrimary : Colors.white70,
                size: 20,
              ),
              4.height,
              Text(
                label,
                style: secondaryTextStyle(
                  size: 12,
                  color: isSelected ? appColorPrimary : Colors.white70,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
