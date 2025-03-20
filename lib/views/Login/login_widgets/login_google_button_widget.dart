import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class LoginGoogleButtonWidget extends StatefulWidget {
  const LoginGoogleButtonWidget({super.key});

  @override
  State<LoginGoogleButtonWidget> createState() =>
      _LoginGoogleButtonWidgetState();
}

class _LoginGoogleButtonWidgetState extends State<LoginGoogleButtonWidget> {
  late ScaleHelper _scaleHelper;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: ColorConstant.dividerColor)),
            SizedBox(width: _scaleHelper.scaleWidth(16)),
            Text(
              "Atau",
              style: TextStyleConstant.textStyleReguler.copyWith(
                fontSize: _scaleHelper.scaleText(12),
                color: ColorConstant.lightTextColor,
              ),
            ),
            SizedBox(width: _scaleHelper.scaleWidth(16)),
            Expanded(child: Divider(color: ColorConstant.dividerColor)),
          ],
        ),
        SizedBox(height: _scaleHelper.scaleHeight(16)),
        SizedBox(
          width: double.infinity,
          height: _scaleHelper.scaleHeight(50),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Tambahkan logika untuk login dengan Google
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
                side: BorderSide(width: 1, color: ColorConstant.borderColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  width: _scaleHelper.scaleWidth(24),
                  height: _scaleHelper.scaleHeight(24)
                ),
                SizedBox(width: _scaleHelper.scaleWidth(8)),
                Text(
                  "Masuk dengan Google",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: _scaleHelper.scaleText(16),
                    color: ColorConstant.blackColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
