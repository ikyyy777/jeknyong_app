import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';

class KonfirmasiTarikSaldoDialog extends StatelessWidget {
  final ScaleHelper scaleHelper;

  const KonfirmasiTarikSaldoDialog({
    super.key,
    required this.scaleHelper,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Tujuan Sudah Benar?',
              style: TextStyleConstant.textStyleSemiBold.copyWith(
                fontSize: scaleHelper.scaleText(16),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            Text(
              'Penarikan akan dikirim ke tujuan yang kamu isi. Kesalahan pengisian diluar tanggung jawab kami.',
              textAlign: TextAlign.center,
              style: TextStyleConstant.textStyleRegular.copyWith(
                fontSize: scaleHelper.scaleText(14),
                color: ColorConstant.darkColor2,
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorConstant.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Cek Kembali',
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: scaleHelper.scaleWidth(16)),
                Expanded(
                  child: ElevatedButton(
                    onPressed:() {
                      Navigator.pushNamed(context, '/penarikan-berhasil');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 