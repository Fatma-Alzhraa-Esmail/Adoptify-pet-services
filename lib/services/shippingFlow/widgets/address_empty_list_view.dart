import 'package:flutter/material.dart';
import 'package:peto_care/assets/assets.dart';
import 'package:peto_care/routers/navigator.dart';
import 'package:peto_care/routers/routers.dart';
import 'package:peto_care/utilities/components/custom_btn.dart';
import 'package:peto_care/utilities/theme/media.dart';
import 'package:peto_care/utilities/theme/text_styles.dart';

import '../../../utilities/theme/colors/light_theme.dart';

class AddressEmptyListView extends StatelessWidget {
  const AddressEmptyListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.assetsImagesNoAddressAdded,
            width: 250,
            height: 250,
          ),
          Text('No address added yet!'),
          CustomBtn(
            onTap: () => CustomNavigator.push(Routes.addNewAddress),
            borderColor: LightTheme().mainColor,
            borderWidth: 1,
            buttonColor: LightTheme().mainColor,
            height: 56,
            radius: 16,
            width: MediaHelper.width - 90,
            text: Text(
              "Add New address",
              style: AppTextStyles.w600
                  .copyWith(color: LightTheme().background, fontSize: 16),
            ),
            textColor: LightTheme().background,
            textContent: "Add New address",
          ),
          // SizedBox(
          //   height: 50,
          // ),
        ],
      ),
    );
  }
}
