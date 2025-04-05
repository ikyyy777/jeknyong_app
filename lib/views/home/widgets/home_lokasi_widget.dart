import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class HomeLokasiWidget extends StatefulWidget {
  const HomeLokasiWidget({super.key});

  @override
  State<HomeLokasiWidget> createState() => _HomeLokasiWidgetState();
}

class _HomeLokasiWidgetState extends State<HomeLokasiWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(174),
      decoration: BoxDecoration(color: ColorConstant.primaryColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: scaleHelper.scaleHeight(26)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: scaleHelper.scaleWidth(40),
                  height: scaleHelper.scaleHeight(40),
                  decoration: BoxDecoration(
                    color: ColorConstant.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorConstant.whiteColor),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.whiteColor,
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(12)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi',
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Kembaran',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(16),
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                        Icon(Icons.expand_more,
                            color: ColorConstant.whiteColor),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
