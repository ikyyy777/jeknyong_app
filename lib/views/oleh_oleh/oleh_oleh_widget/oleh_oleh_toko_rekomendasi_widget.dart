import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/utils/navigation_service.dart';
import 'package:jeknyong_app/views/detail_toko/detail_toko_view.dart';
import 'package:provider/provider.dart';
import 'package:jeknyong_app/controllers/oleh_oleh_controller.dart';
import 'package:jeknyong_app/global_widget/toko_rekomendasi_global_widget.dart';

class OlehOlehTokoRekomendasiWidget extends StatefulWidget {
  const OlehOlehTokoRekomendasiWidget({super.key});

  @override
  State<OlehOlehTokoRekomendasiWidget> createState() =>
      _OlehOlehTokoRekomendasiWidgetState();
}

class _OlehOlehTokoRekomendasiWidgetState
    extends State<OlehOlehTokoRekomendasiWidget> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    return Consumer<OlehOlehController>(
      builder: (context, olehOlehController, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Toko Rekomendasi',
                  style: TextStyleConstant.textStyleSemiBold.copyWith(
                    fontSize: scaleHelper.scaleText(16),
                    color: ColorConstant.blackColor,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    final navigationService = context.read<NavigationService>();
                    navigationService.navigateTo('/toko-rekomendasi');
                  },
                  child: Text(
                    'Lihat Semua',
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(14),
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            ...olehOlehController.tokoRekomendasi
                .take(4)
                .map((toko) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTokoView(tokoName: toko.name),
                          ),
                        );
                      },
                      child: TokoRekomendasiGlobalWidget(toko: toko),
                    ))
                .toList(),
          ],
        );
      }
    );
  }
}
