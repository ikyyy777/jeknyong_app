import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/tarik_saldo_controller.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class SaldoCardWidget extends StatelessWidget {
  final ScaleHelper scaleHelper;
  final TarikSaldoController controller;

  const SaldoCardWidget({
    super.key,
    required this.scaleHelper,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(130),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorConstant.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 16),
            child: Text(
              "Saldoku",
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(4)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Rp. ${controller.currentBalance.toStringAsFixed(0)}",
              style: TextStyleConstant.textStyleBold.copyWith(
                fontSize: scaleHelper.scaleText(28),
              ),
            ),
          ),
          Divider(color: ColorConstant.dividerColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/proses.png',
                  width: scaleHelper.scaleWidth(14),
                  height: scaleHelper.scaleHeight(14),
                ),
                SizedBox(width: scaleHelper.scaleWidth(8)),
                Text(
                  "Rp. 50.000",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(12),
                    color: ColorConstant.greenColor,
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(4)),
                Text(
                  "Sedang Dicairkan",
                  style: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 