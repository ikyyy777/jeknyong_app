import 'package:flutter/material.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:jeknyong_app/global_widget/custom_appbar_global_widget.dart';
import 'package:jeknyong_app/views/profil/widgets/informasi_akun_widget.dart';
import 'package:jeknyong_app/views/profil/widgets/profil_pengguna_widget.dart';
import 'package:provider/provider.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbarGlobalWidget(title: "Profil", showBackButton: false, showShadow: true,),
      
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: scaleHelper.scaleHeight(16)),
                ProfilPenggunaWidget(),
                SizedBox(height: scaleHelper.scaleHeight(24)),
                InformasiAkunWidget()
              ],
            ),
          ),
        ],
      ),
    );
  }
}