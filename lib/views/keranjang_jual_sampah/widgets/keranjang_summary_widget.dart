import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/keranjang_jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangSummaryWidget extends StatelessWidget {
  final Function() onProsesPressed;

  const KeranjangSummaryWidget({
    super.key,
    required this.onProsesPressed,
  });

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final controller = context.watch<KeranjangJualSampahDipilahController>();
    final formatCurrency = NumberFormat.decimalPattern('id');

    return Container(
      padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ringkasan
          Text(
            'Ringkasan',
            style: TextStyleConstant.textStyleSemiBold.copyWith(
              fontSize: scaleHelper.scaleText(16),
            ),
          ),
          SizedBox(height: scaleHelper.scaleHeight(8)),
          // Total berat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Berat:',
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                ),
              ),
              Text(
                '${controller.totalBerat.toStringAsFixed(1)} kg',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                ),
              ),
            ],
          ),
          SizedBox(height: scaleHelper.scaleHeight(4)),
          // Total item
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Item:',
                style: TextStyleConstant.textStyleRegular.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                ),
              ),
              Text(
                '${controller.itemCount} jenis',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                ),
              ),
            ],
          ),
          SizedBox(height: scaleHelper.scaleHeight(4)),
          // Total pendapatan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Pendapatan:',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                ),
              ),
              Text(
                'Rp ${formatCurrency.format(controller.totalHarga)}',
                style: TextStyleConstant.textStyleBold.copyWith(
                  fontSize: scaleHelper.scaleText(16),
                  color: ColorConstant.primaryColor,
                ),
              ),
            ],
          ),

          SizedBox(height: scaleHelper.scaleHeight(16)),

          // Tombol proses penjualan
          SizedBox(
            width: double.infinity,
            height: scaleHelper.scaleHeight(48),
            child: ElevatedButton(
              onPressed: onProsesPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Proses Penjualan',
                style: TextStyleConstant.textStyleSemiBold.copyWith(
                  fontSize: scaleHelper.scaleText(14),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 