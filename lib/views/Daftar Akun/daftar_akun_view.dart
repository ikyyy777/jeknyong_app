import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/color_constant.dart';
import 'package:jeknyong_app/utils/scale_helper.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_akun_button_widget.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_google_button_widget.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_header_widget.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_katasandi_form_widget.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_kebijakan_widget.dart';
import 'package:jeknyong_app/views/Daftar%20Akun/daftar_akun_widgets/daftar_username_form_widget.dart';

class DaftarAkunView extends StatefulWidget {
  const DaftarAkunView({super.key});

  @override
  State<DaftarAkunView> createState() => _DaftarAkunViewState();
}

class _DaftarAkunViewState extends State<DaftarAkunView> {
  late ScaleHelper _scaleHelper;

  @override
  Widget build(BuildContext context) {
    _scaleHelper = ScaleHelper(
      figmaWidth: 360,
      screenWidth: MediaQuery.of(context).size.width,
    );

    return Scaffold(
      backgroundColor: ColorConstant.whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: _scaleHelper.scaleHeight(48)),
              DaftarHeaderWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(24)),
              DaftarUsernameFormWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(16)),
              DaftarKatasandiFormWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(16)),
              DaftarKebijakanWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(24)),
              DaftarAkunButtonWidget(),
              SizedBox(height: _scaleHelper.scaleHeight(16)),
              DaftarGoogleButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
