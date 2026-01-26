import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../helper/dimensions.dart';
import '../helper/responsive_helper.dart';
import '../helper/styles.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All rights reserved By @LeanTek",
              style: ubuntuRegular.copyWith(
                color: Theme.of(
                  context,
                ).textTheme.bodySmall!.color!.withOpacity(.7),
              ),
            ),
            if (!ResponsiveHelper.isMobile(context))
              Row(
                children: [
                  const Text("Profile"),
                  const SizedBox(width: Dimensions.paddingSizeLarge),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radiusExtraLarge),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeLarge),
                  const Icon(Icons.panorama_rounded, size: 24),
                  const SizedBox(width: Dimensions.paddingSizeLarge),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radiusExtraLarge),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeLarge),
                  Text(
                    "Software Version 1.0",
                    style: ubuntuRegular.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
        if (ResponsiveHelper.isMobile(context))
          Row(
            children: [
              Text('profile'.tr),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radiusExtraLarge),
                  ),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              // Image.asset(
              //   AssetIcons.dashboard,
              //   scale: 3,
              //   color: Theme.of(context).textTheme.bodySmall!.color,
              // ),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radiusExtraLarge),
                  ),
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeLarge),
              Text(
                'software_version'.tr,
                style: ubuntuRegular.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget pageNumber(BuildContext context, bool isActive, int pageNumber) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.radiusSmall),
          ),
          color:
              isActive
                  ? Theme.of(
                    context,
                  ).textTheme.bodySmall!.color!.withOpacity(.2)
                  : Colors.transparent,
        ),
        child: Center(child: Text(pageNumber.toString())),
      ),
    );
  }
}
