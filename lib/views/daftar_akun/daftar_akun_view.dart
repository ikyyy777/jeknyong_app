import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_akun_button_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_google_button_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_header_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_katasandi_form_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_kebijakan_widget.dart';
import 'package:jeknyong_app/views/daftar_akun/widgets/daftar_akun_widgets/daftar_username_form_widget.dart';
import 'package:provider/provider.dart';

class DaftarAkunView extends StatefulWidget {
  const DaftarAkunView({super.key});

  @override
  State<DaftarAkunView> createState() => _DaftarAkunViewState();
}

class _DaftarAkunViewState extends State<DaftarAkunView> {
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
              DaftarHeaderWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              DaftarUsernameFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              DaftarKatasandiFormWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              DaftarKebijakanWidget(),
              SizedBox(height: scaleHelper.scaleHeight(24)),
              DaftarAkunButtonWidget(),
              SizedBox(height: scaleHelper.scaleHeight(16)),
              DaftarGoogleButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
