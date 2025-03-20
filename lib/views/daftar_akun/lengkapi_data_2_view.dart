import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_desa_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_header_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_kecamatan_form_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_kode_pos_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_rt_rw_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_2_selanjutnya_button_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/lengkapi_data_2_widgets/lengkapi_data_alamat_lengkap_widget.dart';
import 'package:provider/provider.dart';

class LengkapiData2View extends StatefulWidget {
  const LengkapiData2View({super.key});

  @override
  State<LengkapiData2View> createState() => _LengkapiData2ViewState();
}

class _LengkapiData2ViewState extends State<LengkapiData2View> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: scaleHelper.scaleHeight(48)),
              LengkapiData2HeaderWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LengkapiData2KecamatanFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiData2DesaWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiData2KodePosWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiData2RtRwWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              LengkapiDataAlamatLengkapWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              LengkapiData2SelanjutnyaButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
