import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/home_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class HomeInfoJeknyongWidget extends StatefulWidget {
  const HomeInfoJeknyongWidget({super.key});

  @override
  State<HomeInfoJeknyongWidget> createState() => _HomeInfoJeknyongWidgetState();
}

class _HomeInfoJeknyongWidgetState extends State<HomeInfoJeknyongWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Transform.translate(
      offset: Offset(0, scaleHelper.scaleHeight(-95)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: scaleHelper.scaleWidth(16),
            ),
            child: Text(
              "Info Jeknyong",
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
                color: ColorConstant.blackColor,
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          CarouselSlider(
            options: CarouselOptions(
              height: scaleHelper.scaleHeight(144),
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              enableInfiniteScroll: false,
              viewportFraction: 1,
              enlargeCenterPage: true,
            ),
            items:
                context
                    .read<HomeController>()
                    .infoJeknyongBanner
                    .map(
                      (item) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Image.asset(item),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
