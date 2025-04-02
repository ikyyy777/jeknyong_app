import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/detail_toko_controller.dart';
import 'package:provider/provider.dart';

class DetailTokoImageBannerWidget extends StatefulWidget {
  final String tokoName;

  const DetailTokoImageBannerWidget({super.key, required this.tokoName});

  @override
  State<DetailTokoImageBannerWidget> createState() =>
      _DetailTokoImageBannerWidgetState();
}

class _DetailTokoImageBannerWidgetState
    extends State<DetailTokoImageBannerWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Consumer<DetailTokoController>(
      builder: (context, detailTokoController, child) {
        final detailToko = detailTokoController.detailToko[widget.tokoName];

        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: scaleHelper.scaleHeight(240),
              color: Colors.red,
              child: Image.asset(
                detailToko?.image ?? 'assets/images/sablon_kaos_banner.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: scaleHelper.scaleHeight(16),
              left: scaleHelper.scaleWidth(16),
              right: scaleHelper.scaleWidth(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child: Icon(
                        Icons.arrow_back,
                        color: ColorConstant.blackColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/keranjang-oleh-oleh');
                    },
                    child: Container(
                      width: scaleHelper.scaleWidth(40),
                      height: scaleHelper.scaleHeight(40),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        border: Border.all(color: ColorConstant.borderColor),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        color: ColorConstant.blackColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
