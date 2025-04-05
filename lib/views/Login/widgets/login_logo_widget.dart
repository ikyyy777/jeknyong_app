import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LoginLogoWidget extends StatelessWidget {
  const LoginLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Row(
      children: [
        Image.asset('assets/images/logo.png', width: scaleHelper.scaleWidth(66)),
        SizedBox(width: scaleHelper.scaleWidth(9)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: scaleHelper.scaleHeight(28),
              decoration: BoxDecoration(color: ColorConstant.redColor),
              child: Text(
                ' J E K N Y O N G ',
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(20),
                  color: ColorConstant.whiteColor,
                ),
              ),
            ),
            Text(
              'BANYUMAS',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(20),
                color: ColorConstant.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
