import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/models/toko_rekomendasi_model.dart';
import 'package:provider/provider.dart';

class TokoRekomendasiGlobalWidget extends StatelessWidget {
  final TokoRekomendasi toko;

  const TokoRekomendasiGlobalWidget({
    super.key,
    required this.toko,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Container(
      margin: EdgeInsets.only(bottom: scaleHelper.scaleHeight(16)),
      child: Row(
        children: [
          Container(
            width: scaleHelper.scaleWidth(80),
            height: scaleHelper.scaleHeight(80),
            decoration: BoxDecoration(
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorConstant.primaryColor),
            ),
            child: Image.asset(toko.image),
          ),
          SizedBox(width: scaleHelper.scaleWidth(8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  toko.name,
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                    color: ColorConstant.blackColor,
                  ),
                ),
                SizedBox(height: scaleHelper.scaleHeight(4)),
                Text(
                  toko.category,
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(12),
                    color: ColorConstant.blackColor,
                  ),
                ),
                SizedBox(height: scaleHelper.scaleHeight(8)),
                Row(
                  children: [
                    Icon(Icons.star, color: ColorConstant.yellowColor),
                    Text(
                      toko.rating.toString(),
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(12),
                        color: ColorConstant.blackColor,
                      ),
                    ),
                    SizedBox(width: scaleHelper.scaleWidth(8)),
                    Icon(Icons.location_on, color: ColorConstant.primaryColor),
                    Text(
                      '${toko.distance} km',
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(12),
                        color: ColorConstant.blackColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}