import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LoginGoogleButtonWidget extends StatefulWidget {
  const LoginGoogleButtonWidget({super.key});

  @override
  State<LoginGoogleButtonWidget> createState() =>
      _LoginGoogleButtonWidgetState();
}

class _LoginGoogleButtonWidgetState extends State<LoginGoogleButtonWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Divider(color: ColorConstant.dividerColor)),
            SizedBox(width: scaleHelper.scaleWidth(16)),
            Text(
              "Atau",
              style: TextStyleConstant.textStyleReguler.copyWith(
                fontSize: scaleHelper.scaleText(12),
                color: ColorConstant.lightTextColor,
              ),
            ),
            SizedBox(width: scaleHelper.scaleWidth(16)),
            Expanded(child: Divider(color: ColorConstant.dividerColor)),
          ],
        ),
        SizedBox(height: scaleHelper.scaleHeight(16)),
        SizedBox(
          width: double.infinity,
          height: scaleHelper.scaleHeight(50),
          child: ElevatedButton(
            onPressed: () {
              // TODO: Tambahkan logika untuk login dengan Google
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConstant.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                side: BorderSide(width: 1, color: ColorConstant.borderColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  width: scaleHelper.scaleWidth(24),
                  height: scaleHelper.scaleHeight(24)
                ),
                SizedBox(width: scaleHelper.scaleWidth(8)),
                Text(
                  "Masuk dengan Google",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
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
