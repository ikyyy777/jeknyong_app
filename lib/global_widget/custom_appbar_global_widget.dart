import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class CustomAppbarGlobalWidget extends StatelessWidget {
  final String title;
  final bool showBackButton;
  const CustomAppbarGlobalWidget({
    super.key,
    required this.title,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(98),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: scaleHelper.scaleHeight(16)),
        child: Row(
          children: [
            if (showBackButton)
              Padding(
                padding: EdgeInsets.only(left: scaleHelper.scaleWidth(16)),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: scaleHelper.scaleWidth(40),
                    height: scaleHelper.scaleHeight(40),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      border: Border.all(color: ColorConstant.borderColor),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Icon(Icons.arrow_back, color: ColorConstant.blackColor),
                  ),
                ),
              ),
            Expanded(
              child: Center(
                child: Text(
                  title,
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                    color: ColorConstant.blackColor,
                  ),
                ),
              ),
            ),
            if (showBackButton)
              SizedBox(width: scaleHelper.scaleWidth(56)), // Untuk menyeimbangkan layout
          ],
        ),
      ),
    );
  }
}
