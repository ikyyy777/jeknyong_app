import 'package:flutter/material.dart';
import 'package:jeknyong_app/constants/textstyle_constant.dart';
import 'package:jeknyong_app/controllers/scale_factor_controller.dart';
import 'package:provider/provider.dart';

class ProfilPenggunaWidget extends StatelessWidget {
  const ProfilPenggunaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleHelper = context.read<ScaleFactorController>().scaleHelper;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Profil Pengguna",
          style: TextStyleConstant.textStyleSemiBold.copyWith(
            fontSize: scaleHelper.scaleText(16),
          ),
        ),
        SizedBox(height: scaleHelper.scaleHeight(19)),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Container(
            width: scaleHelper.scaleWidth(60),
            height: scaleHelper.scaleHeight(60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/dummy_profile.png'),
              ),
            ),
          ),
          title: Text(
            "Wendri Tri Pambudi",
            style: TextStyleConstant.textStyleSemiBold.copyWith(
              fontSize: scaleHelper.scaleText(16),
            ),
          ),
          subtitle: Text(
            "wendri666@gmail.com",
            style: TextStyleConstant.textStyleRegular.copyWith(
              fontSize: scaleHelper.scaleText(14),
            ),
          ),
        ),
      ],
    );
  }
}
