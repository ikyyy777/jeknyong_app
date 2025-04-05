import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/home/widgets/home_info_jeknyong_widget.dart';
import 'package:jeknyong_app/views/home/widgets/home_lokasi_widget.dart';
import 'package:jeknyong_app/views/home/widgets/home_menu_lain_widget.dart';
import 'package:jeknyong_app/views/home/widgets/home_riwayat_transaksi_widget.dart';
import 'package:jeknyong_app/views/home/widgets/home_saldoku_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeLokasiWidget(),
              HomeSaldokuWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              HomeMenuLainWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              HomeInfoJeknyongWidget(),
              SizedBox(height: scaleHelper.scaleHeight(20)),
              HomeRiwayatTransaksiWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
