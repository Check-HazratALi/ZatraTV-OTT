import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:zatra_tv/screens/dashboard/dashboard_controller.dart';
import 'package:zatra_tv/screens/home/home_controller.dart';
import 'package:zatra_tv/screens/setting/setting_controller.dart';
import 'package:zatra_tv/utils/app_common.dart';
import '../../../components/app_scaffold.dart';
import '../../../locale/app_localizations.dart';
import '../../../locale/languages.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';

class LanguageScreen extends StatelessWidget {
  final SettingController settingController;
  const LanguageScreen({super.key, required this.settingController});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: false.obs,
      scaffoldBackgroundColor: appScreenBackgroundDark,
      appBartitleText: locale.value.language,
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
          ListView.builder(
            padding: const EdgeInsets.only(bottom: 30, top: 16),
            itemBuilder: (_, index) {
              LanguageDataModel data = localeLanguageList[index];

              return SettingItemWidget(
                title: data.name.validate(),
                subTitle: data.subTitle,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                titleTextStyle: primaryTextStyle(),
                leading: (data.flag.validate().isNotEmpty)
                    ? data.flag.validate().startsWith('http')
                          ? Image.network(data.flag.validate(), width: 24)
                          : Image.asset(data.flag.validate(), width: 24)
                    : null,
                trailing: Obx(
                  () =>
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: boxDecorationDefault(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 15,
                          color: Colors.black,
                        ),
                      ).visible(
                        selectedLanguageCode.value ==
                            data.languageCode.validate(),
                      ),
                ),
                splashColor: appColorPrimary.withValues(alpha: 0.2),
                borderRadius: 8,
                highlightColor: appColorPrimary.withValues(alpha: 0.2),
                onTap: () async {
                  await setValue(SELECTED_LANGUAGE_CODE, data.languageCode);
                  selectedLanguageDataModel = data;
                  BaseLanguage temp = await const AppLocalizations().load(
                    Locale(data.languageCode.validate()),
                  );
                  locale = temp.obs;
                  setValueToLocal(
                    SELECTED_LANGUAGE_CODE,
                    data.languageCode.validate(),
                  );
                  isRTL(Constants.rtlLanguage.contains(data.languageCode));
                  selectedLanguageCode(data.languageCode.validate());
                  Get.updateLocale(Locale(data.languageCode.validate()));
                  settingController.settingList.clear();
                  settingController.getInitListData();
                  DashboardController dashboardController = Get.find();
                  dashboardController.addDataOnBottomNav();
                  getDashboardController().onBottomTabChange(0);
                  HomeController homeController = Get.find();
                  homeController.createCategorySections(
                    homeController.dashboardDetail.value,
                    true,
                  );
                },
              );
            },
            shrinkWrap: true,
            itemCount: localeLanguageList.length,
          ),
        ],
      ),
    );
  }
}
