import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/oleh_oleh_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class OlehOlehBannerWidget extends StatefulWidget {
  const OlehOlehBannerWidget({super.key});

  @override
  State<OlehOlehBannerWidget> createState() => _OlehOlehBannerWidgetState();
}

class _OlehOlehBannerWidgetState extends State<OlehOlehBannerWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: scaleHelper.scaleHeight(144),
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            enableInfiniteScroll: false,
            viewportFraction: 1,
            enlargeCenterPage: true,
          ),
          items: context
              .read<OlehOlehController>()
              .olehOlehBanner
              .map(
                (item) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(item),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
