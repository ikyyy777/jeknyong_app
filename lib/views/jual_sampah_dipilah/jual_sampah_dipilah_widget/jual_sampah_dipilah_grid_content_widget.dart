import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/controllers/jual_sampah_dipilah_controller.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JualSampahDipilahGridContentWidget extends StatefulWidget {
  const JualSampahDipilahGridContentWidget({super.key});

  @override
  State<JualSampahDipilahGridContentWidget> createState() =>
      _JualSampahDipilahGridContentWidgetState();
}

class _JualSampahDipilahGridContentWidgetState
    extends State<JualSampahDipilahGridContentWidget> {
  final formatCurrency = NumberFormat.decimalPattern('id');

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;
    final jualSampahController = context.watch<JualSampahDipilahController>();
    final daftarSampah = jualSampahController.daftarJenisSampah;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jenis Sampah",
            style: TextStyleConstant.textStyleSemiBold.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
          
          // Grid view sampah
          daftarSampah.isEmpty
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: scaleHelper.scaleHeight(40)),
                    child: Text(
                      "Tidak ada jenis sampah tersedia",
                      style: TextStyleConstant.textStyleRegular.copyWith(
                        fontSize: scaleHelper.scaleText(14),
                        color: ColorConstant.darkColor3,
                      ),
                    ),
                  ),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.70,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: daftarSampah.length,
                  itemBuilder: (context, index) {
                    final sampah = daftarSampah[index];
                    return _buildSampahItem(sampah, scaleHelper);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildSampahItem(JenisSampah sampah, ScaleHelper scaleHelper) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke detail sampah atau tambahkan ke keranjang
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ColorConstant.darkColor4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar sampah
            Container(
              width: double.infinity,
              height: scaleHelper.scaleHeight(120),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(sampah.gambar),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        "Min ${sampah.minimumBerat}kg",
                        style: TextStyleConstant.textStyleSemiBold.copyWith(
                          fontSize: scaleHelper.scaleText(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Detail sampah
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      sampah.kategori,
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(10),
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(6)),
                  Text(
                    sampah.nama,
                    style: TextStyleConstant.textStyleSemiBold.copyWith(
                      fontSize: scaleHelper.scaleText(14),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: scaleHelper.scaleHeight(6)),
                  Row(
                    children: [
                      Text(
                        "Rp ${formatCurrency.format(sampah.hargaPerKg)}",
                        style: TextStyleConstant.textStyleBold.copyWith(
                          fontSize: scaleHelper.scaleText(14),
                          color: ColorConstant.greenColor,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        "/Kg",
                        style: TextStyleConstant.textStyleRegular.copyWith(
                          fontSize: scaleHelper.scaleText(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
