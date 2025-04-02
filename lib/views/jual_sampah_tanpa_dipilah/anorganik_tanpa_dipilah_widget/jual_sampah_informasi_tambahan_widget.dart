import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/jual_sampah_tanpa_dipilah_controller.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class JualSampahInformasiTambahanWidget extends StatelessWidget {
  const JualSampahInformasiTambahanWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      width: double.infinity,
      height: scaleHelper.scaleHeight(280),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Tambahan",
              style: TextStyleConstant.textStyleSemiBold.copyWith(fontSize: scaleHelper.scaleText(16)),
            ),
            SizedBox(height: scaleHelper.scaleHeight(12)),
            Row(
              children: [
                Text(
                  "No Hp",
                  style: TextStyleConstant.textStyleRegular.copyWith(fontSize: scaleHelper.scaleText(14)),
                ),
                Text(
                  "*",
                  style: TextStyleConstant.textStyleRegular.copyWith(fontSize: scaleHelper.scaleText(14), color: ColorConstant.redColor),
                ),
              ],
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Consumer<JualSampahTanpaDipilahController>(
              builder: (context, controller, child) {                
                return SizedBox(
                  height: scaleHelper.scaleHeight(48),
                  child: TextField(
                    controller: controller.noHpController,
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    onChanged: (value) {
                      // Tambahkan penanganan onChange langsung
                      controller.setNoHP(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Masukkan nomor handphone',
                      counterText: '',
                      hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Text(
              "Catatan",
              style: TextStyleConstant.textStyleRegular.copyWith(fontSize: scaleHelper.scaleText(14)),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Consumer<JualSampahTanpaDipilahController>(
              builder: (context, controller, child) {
                return SizedBox(
                  height: scaleHelper.scaleHeight(80),
                  child: TextField(
                    controller: controller.catatanController,
                    maxLines: 3,
                    onChanged: (value) {
                      controller.setCatatan(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Tambahkan catatan untuk pesanan',
                      hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(scaleHelper.scaleWidth(10)),
                        borderSide: BorderSide(width: 1, color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}