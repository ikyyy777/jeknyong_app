import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class LengkapiData2HeaderWidget extends StatelessWidget {
  const LengkapiData2HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
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
        SizedBox(height: scaleHelper.scaleHeight(16)),
        Row(
          children: [
            Text(
              'Lengkapi Data',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(24),
                color: ColorConstant.blackColor,
              ),
            ),
            Spacer(),
            Text(
              '2/2',
              style: TextStyleConstant.textStyleBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
                color: ColorConstant.blackColor,
              ),
            ),
          ],
        ),
        SizedBox(height: scaleHelper.scaleHeight(8)),
        Text(
          'Tambahkan Alamat',
          style: TextStyleConstant.textStyleReguler.copyWith(
            fontSize: scaleHelper.scaleText(14),
            color: ColorConstant.lightTextColor,
          ),
        ),
      ],
    );
  }
}
