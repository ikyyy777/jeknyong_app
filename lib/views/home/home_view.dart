import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
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
                                  style: TextStyleConstant.textStyleSemiBold
                                      .copyWith(
                                        fontSize: scaleHelper.scaleText(16),
                                        color: ColorConstant.whiteColor,
                                      ),
                                ),
                                Text(
                                  'Kembaran',
                                  style: TextStyleConstant.textStyleSemiBold
                                      .copyWith(
                                        fontSize: scaleHelper.scaleText(16),
                                        color: ColorConstant.whiteColor,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: scaleHelper.scaleHeight(85),
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: scaleHelper.scaleHeight(1000),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scaleHelper.scaleHeight(20)),
                      Text(
                        'Saldoku',
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(16),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                      SizedBox(height: scaleHelper.scaleHeight(4)),
                      Text(
                        'Rp. 134.000',
                        style: TextStyleConstant.textStyleBold.copyWith(
                          fontSize: scaleHelper.scaleText(28),
                          color: ColorConstant.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
