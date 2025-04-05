import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LengkapiDataSelanjutnyaButtonWidget extends StatefulWidget {
  const LengkapiDataSelanjutnyaButtonWidget({super.key});

  @override
  State<LengkapiDataSelanjutnyaButtonWidget> createState() =>
      _LengkapiDataSelanjutnyaButtonWidgetState();
}

class _LengkapiDataSelanjutnyaButtonWidgetState
    extends State<LengkapiDataSelanjutnyaButtonWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return SizedBox(
      width: double.infinity,
      height: scaleHelper.scaleHeight(50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/lengkapi-data-2');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.lerp(
            ColorConstant.whiteColor,
            ColorConstant.primaryColor,
            0.95,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
            side: BorderSide(width: 1, color: ColorConstant.primaryColor),
          ),
        ),
        child: Text(
          "Selanjutnya",
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
            color: ColorConstant.whiteColor,
          ),
        ),
      ),
    );
  }
}
