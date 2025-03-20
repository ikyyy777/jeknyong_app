import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class LoginLogoWidget extends StatefulWidget {
  const LoginLogoWidget({super.key});

  @override
  State<LoginLogoWidget> createState() => _LoginLogoWidgetState();
}

class _LoginLogoWidgetState extends State<LoginLogoWidget> {
  late ScaleHelper _scaleHelper;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );
    return Row(
      children: [
        Image.asset('assets/images/logo.png', width: _scaleHelper.scaleWidth(66)),
        SizedBox(width: _scaleHelper.scaleWidth(9)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: _scaleHelper.scaleHeight(28),
              decoration: BoxDecoration(color: ColorConstant.redColor),
              child: Text(
                ' J E K N Y O N G ',
                style: TextStyleConstant.textStyleReguler.copyWith(
                  fontSize: _scaleHelper.scaleText(20),
                  color: ColorConstant.whiteColor,
                ),
              ),
            ),
            Text(
              'BANYUMAS',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: _scaleHelper.scaleText(20),
                color: ColorConstant.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
