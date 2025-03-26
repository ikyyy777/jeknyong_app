import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class KeranjangOlehOlehInformasiTambahanWidget extends StatefulWidget {
  const KeranjangOlehOlehInformasiTambahanWidget({super.key});

  @override
  State<KeranjangOlehOlehInformasiTambahanWidget> createState() =>
      _KeranjangOlehOlehInformasiTambahanWidgetState();
}

class _KeranjangOlehOlehInformasiTambahanWidgetState
    extends State<KeranjangOlehOlehInformasiTambahanWidget> {
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
            SizedBox(height: scaleHelper.scaleHeight(12),),
            Text(
              "No Hp",
              style: TextStyleConstant.textStyleRegular.copyWith(fontSize: scaleHelper.scaleText(14)),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            SizedBox(
              height: scaleHelper.scaleHeight(48),
              child: TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukkan nomor handphone',
                  hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Text(
              "Catatan",
              style: TextStyleConstant.textStyleRegular.copyWith(fontSize: scaleHelper.scaleText(14)),
            ),
            SizedBox(height: scaleHelper.scaleHeight(8)),
            SizedBox(
              height: scaleHelper.scaleHeight(80),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tambahkan catatan untuk pesanan',
                  hintStyle: TextStyleConstant.textStyleRegular.copyWith(
                    fontSize: scaleHelper.scaleText(14),
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      scaleHelper.scaleWidth(10),
                    ),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
