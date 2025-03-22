import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class OlehOlehLokasiWidget extends StatefulWidget {
  const OlehOlehLokasiWidget({super.key});

  @override
  State<OlehOlehLokasiWidget> createState() => _OlehOlehLokasiWidgetState();
}

class _OlehOlehLokasiWidgetState extends State<OlehOlehLokasiWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;
    
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: scaleHelper.scaleHeight(46)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: scaleHelper.scaleWidth(40),
                  height: scaleHelper.scaleHeight(40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ColorConstant.darkColor3),
                  ),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: ColorConstant.blackColor,
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(12)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lokasi',
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                        color: ColorConstant.blackColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Kembaran',
                          style: TextStyleConstant.textStyleBold
                              .copyWith(
                                fontSize: scaleHelper.scaleText(16),
                                color: ColorConstant.primaryColor,
                              ),
                        ),
                        Icon(
                          Icons.expand_more,
                          color: ColorConstant.primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}