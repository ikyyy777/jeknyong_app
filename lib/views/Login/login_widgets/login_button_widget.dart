import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget({super.key});

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  late ScaleHelper _scaleHelper;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return SizedBox(
      width: double.infinity,
      height: _scaleHelper.scaleHeight(50),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Tambahkan logika untuk login
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.lerp(
            ColorConstant.whiteColor,
            ColorConstant.primaryColor,
            0.95,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_scaleHelper.scaleWidth(10)),
            side: BorderSide(width: 1, color: ColorConstant.primaryColor),
          ),
        ),
        child: Text(
          "Masuk",
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: _scaleHelper.scaleText(16),
            color: ColorConstant.whiteColor,
          ),
        ),
      ),
    );
  }
}
