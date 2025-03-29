import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/anorganik_tanpa_dipilah/anorganik_tanpa_dipilah_widget/anorganik_alamat_widget.dart';
import 'package:jeknyong_app/views/anorganik_tanpa_dipilah/anorganik_tanpa_dipilah_widget/anorganik_foto_sampah_widget.dart';
import 'package:jeknyong_app/views/anorganik_tanpa_dipilah/anorganik_tanpa_dipilah_widget/anorganik_informasi_tambahan_widget.dart';
import 'package:provider/provider.dart';

class AnorganikTanpaDipilahView extends StatefulWidget {
  const AnorganikTanpaDipilahView({super.key});

  @override
  State<AnorganikTanpaDipilahView> createState() =>
      _AnorganikTanpaDipilahViewState();
}

class _AnorganikTanpaDipilahViewState extends State<AnorganikTanpaDipilahView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.greyColor2,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbarGlobalWidget(
              title: "Anorganik Tanpa Dipilah",
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  AnorganikAlamatWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  AnorganikInformasiTambahanWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                  AnorganikFotoSampahWidget(),
                  SizedBox(height: scaleHelper.scaleHeight(16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
