import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_gender_form_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_header_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_nama_form_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_nik_form_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_nomor_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_1_widgets/lengkapi_data_selanjutnya_button_widget.dart';
import 'package:provider/provider.dart';

class LengkapiData1View extends StatefulWidget {
  const LengkapiData1View({super.key});

  @override
  State<LengkapiData1View> createState() => _LengkapiData1ViewState();
}

class _LengkapiData1ViewState extends State<LengkapiData1View> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScaleFactorController>().initScaleHelper(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.watch<ScaleFactorController>().scaleHelper;

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaleHelper.scaleHeight(48)),
              LengkapiDataHeaderWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LengkapiDataNamaFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiDataGenderFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiDataNikFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiDataNomorWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LengkapiDataSelanjutnyaButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
