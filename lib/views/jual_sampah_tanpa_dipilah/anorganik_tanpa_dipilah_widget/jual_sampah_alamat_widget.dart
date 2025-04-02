import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class JualSampahAlamatWidget extends StatefulWidget {
  const JualSampahAlamatWidget({super.key});

  @override
  State<JualSampahAlamatWidget> createState() => _JualSampahAlamatWidgetState();
}

class _JualSampahAlamatWidgetState extends State<JualSampahAlamatWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(166),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Alamat Saya',
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                    color: ColorConstant.blackColor,
                  ),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Text(
              'Slamet',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.darkColor2,
              ),
            ),
            Text(
              'Jalan Masjid No. 2 RT 04 RW 01, Kembaran , Banyumas, Jawa Tengah 53182',
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.darkColor2,
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Ganti Alamat",
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  color: ColorConstant.primaryColor,
                  fontSize: scaleHelper.scaleText(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
