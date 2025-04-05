import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:provider/provider.dart';

class KeranjangJualSampahDipilahView extends StatefulWidget {
  const KeranjangJualSampahDipilahView({super.key});

  @override
  State<KeranjangJualSampahDipilahView> createState() =>
      _KeranjangJualSampahDipilahViewState();
}

class _KeranjangJualSampahDipilahViewState
    extends State<KeranjangJualSampahDipilahView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.greyColor2,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomAppbarGlobalWidget(title: "Keranjang Jual Sampah"),
            SizedBox(height: scaleHelper.scaleHeight(16)),
            Container(
              width: double.infinity,
              height: scaleHelper.scaleHeight(245),
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Daftar Jenis Sampah",
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: scaleHelper.scaleText(16),
                      ),
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(12)),
                    Divider(),
                    Row(
                      children: [
                        Container(
                          width: scaleHelper.scaleWidth(82),
                          height: scaleHelper.scaleHeight(82),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage('assets/images/dummy_image.jpg'),
                            ),
                          ),
                        ),
                        SizedBox(width: scaleHelper.scaleWidth(12)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama Sampah",
                              style: TextStyleConstant.textStyleSemiBold.copyWith(
                                fontSize: scaleHelper.scaleText(16),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rp 300,- ",
                                  style: TextStyleConstant.textStyleBold.copyWith(
                                    fontSize: scaleHelper.scaleText(16),
                                    color: ColorConstant.greenColor
                                  ),
                                ),
                                Text(
                                  "/Kg",
                                  style: TextStyleConstant.textStyleRegular.copyWith(
                                    fontSize: scaleHelper.scaleText(16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
