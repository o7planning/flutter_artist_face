import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/localization_controller.dart';
import '../helper/dimensions.dart';
import '../helper/styles.dart';
import '../model/language_model.dart';

class LanguageWidget extends StatelessWidget {
  final LanguageModel languageModel;
  final LocalizationController localizationController;
  final int index;

  const LanguageWidget({
    super.key,
    required this.languageModel,
    required this.localizationController,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var languageController = Get.find();
    //
    return InkWell(
      onTap: () {
        localizationController.setSelectIndex(index);
        localizationController.setLanguage(
          Locale(
            languageController
                .languages[localizationController.selectedIndex]
                .languageCode!,
            languageController
                .languages[localizationController.selectedIndex]
                .countryCode,
          ),
        );
        Get.back();
      },
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        decoration: BoxDecoration(
          border:
              localizationController.selectedIndex == index
                  ? Border.all(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.color!.withOpacity(.2),
                    width: 1,
                  )
                  : null,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        ),
        child: Center(
          child: Text(languageModel.languageName, style: ubuntuRegular),
        ),
      ),
    );
  }
}
