import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/jual_sampah/jual_sampah_widget/jual_sampah_anorganik_widget.dart';
import 'package:jeknyong_app/views/jual_sampah/jual_sampah_widget/jual_sampah_dipilah_widget.dart';
import 'package:provider/provider.dart';

class JualSampahView extends StatefulWidget {
  const JualSampahView({super.key});

  @override
  State<JualSampahView> createState() => _JualSampahViewState();
}

class _JualSampahViewState extends State<JualSampahView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: ColorConstant.greyColor2,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            CustomAppbarGlobalWidget(
              title: "Jual Sampah",
              showBackButton: false,
            ),
            SizedBox(height: scaleHelper.scaleHeight(10)),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              color: ColorConstant.whiteColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Jenis Sampah Kamu",
                      style: TextStyleConstant.textStyleSemiBold.copyWith(
                        fontSize: 16,
                        color: ColorConstant.blackColor,
                      ),
                    ),
                    SizedBox(height: scaleHelper.scaleHeight(12)),
                    JualSampahAnorganikWidget(),
                    SizedBox(height: scaleHelper.scaleHeight(16),),
                    JualSampahDipilahWidget()
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
