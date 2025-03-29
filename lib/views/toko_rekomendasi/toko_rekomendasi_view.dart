import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/toko_rekomendasi/toko_rekomendasi_widgets/toko_rekomendasi_content_widget.dart';
import 'package:jeknyong_app/views/toko_rekomendasi/toko_rekomendasi_widgets/toko_rekomendasi_header_widget.dart';
import 'package:provider/provider.dart';

class TokoRekomendasiView extends StatefulWidget {
  const TokoRekomendasiView({super.key});

  @override
  State<TokoRekomendasiView> createState() => _TokoRekomendasiViewState();
}

class _TokoRekomendasiViewState extends State<TokoRekomendasiView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: scaleHelper.scaleWidth(16)),
          child: Column(
            children: [
              SizedBox(height: scaleHelper.scaleHeight(24)),
              TokoRekomendasiHeaderWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              TokoRekomendasiContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
