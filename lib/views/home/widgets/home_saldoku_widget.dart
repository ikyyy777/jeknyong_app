import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class HomeSaldokuWidget extends StatefulWidget {
  const HomeSaldokuWidget({super.key});

  @override
  State<HomeSaldokuWidget> createState() => _HomeSaldokuWidgetState();
}

class _HomeSaldokuWidgetState extends State<HomeSaldokuWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Transform.translate(
      offset: Offset(0, scaleHelper.scaleHeight(-95)),
      child: Container(
        width: double.infinity,
        height: scaleHelper.scaleHeight(196),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: scaleHelper.scaleHeight(20)),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Saldoku',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                  color: ColorConstant.blackColor,
                ),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(4)),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Rp. 134.000',
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: scaleHelper.scaleText(28),
                  color: ColorConstant.blackColor,
                ),
              ),
            ),
            Divider(color: ColorConstant.dividerColor2, thickness: 1),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/proses.png',
                        width: scaleHelper.scaleWidth(14),
                        height: scaleHelper.scaleHeight(14),
                      ),
                      SizedBox(width: scaleHelper.scaleWidth(8)),
                      Text(
                        "1",
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                      Text(
                        ' Proses',
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/selesai.png',
                        width: scaleHelper.scaleWidth(14),
                        height: scaleHelper.scaleHeight(14),
                      ),
                      SizedBox(width: scaleHelper.scaleWidth(8)),
                      Text(
                        "12",
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                      Text(
                        ' Selesai',
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/batal.png',
                        width: scaleHelper.scaleWidth(14),
                        height: scaleHelper.scaleHeight(14),
                      ),
                      SizedBox(width: scaleHelper.scaleWidth(8)),
                      Text(
                        "0",
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                      Text(
                        ' Batal',
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: scaleHelper.scaleHeight(40),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          'Jual Sampah',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: scaleHelper.scaleHeight(40),
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: ColorConstant.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Tarik Saldo',
                          style: TextStyleConstant.textStyleSemiBold.copyWith(
                            fontSize: scaleHelper.scaleText(14),
                            color: ColorConstant.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
