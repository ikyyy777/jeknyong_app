import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/keranjang_controller.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class KeranjangOlehOlehRincianBiayaWidget extends StatefulWidget {
  const KeranjangOlehOlehRincianBiayaWidget({super.key});

  @override
  State<KeranjangOlehOlehRincianBiayaWidget> createState() =>
      _KeranjangOlehOlehRincianBiayaWidgetState();
}

class _KeranjangOlehOlehRincianBiayaWidgetState
    extends State<KeranjangOlehOlehRincianBiayaWidget> {
  final formatCurrency = NumberFormat.decimalPattern('id');
  final ongkosKirim = 10000.0;

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    
    return Consumer<KeranjangController>(
      builder: (context, keranjangController, child) {
        final totalBelanja = keranjangController.getTotalPrice();
        
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(scaleHelper.scaleWidth(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rincian Biaya",
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                  ),
                ),
                SizedBox(height: scaleHelper.scaleHeight(12)),
                Row(
                  children: [
                    Text(
                      "Total Belanja",
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Rp ${formatCurrency.format(totalBelanja)}",
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: scaleHelper.scaleHeight(8)),
                Row(
                  children: [
                    Text(
                      "Ongkos Kirim",
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Rp ${formatCurrency.format(ongkosKirim)}",
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: scaleHelper.scaleHeight(12)),
                Divider(color: ColorConstant.dividerColor),
                SizedBox(height: scaleHelper.scaleHeight(12)),
              ],
            ),
          ),
        );
      },
    );
  }
}
